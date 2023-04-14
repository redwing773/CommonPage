import encrypt from '../util/Encrypt.js';

let listQuery = null;
let unListQuery = null;

class SendbirdAction {
    sb = null;
    channelUrl = null;
    channel = null;

    constructor(appId, key) {
        this.init(appId, key)
    }

    /**
     * 샌드버드 객체 및 채널 핸들러 생성
     *
     * @param {string} appId sendbird app id
     * @param {string} key key
     * @return {}
     */
    init(appId, key) {
        this.sb = new SendBird({appId: encrypt.aes256Decode(key, '', appId), localCacheEnabled: true });

        const channelHandler = new this.sb.ChannelHandler();
        this.channelHandler = channelHandler;
        this.sb.addChannelHandler('chat', this.channelHandler);
    }

    /**
     * 샌드버드 연결
     *
     * @param {string} userId 연결 ID
     * @param {string} accessToken 연결 토큰
     * @return {}
     */
    connect(userId, accessToken) {
        return new Promise((resolve, reject) => {
            this.sb.connect(userId, accessToken, function(user, error) {
                error ? reject(error) : resolve(user)
            });
        });
    }

    /**
     * 샌드버드 연결 해제
     *
     * @return {}
     */
    disconnect(){
        return new Promise((resolve, reject) => {
            this.sb.disconnect(function() {
                console.info("The current user is disconnected from Sendbird server.");
                resolve();
            });
        });
    }

    /**
     * 공개 채널 연결 (불특정 다수 접근)
     *
     * @param {string} url 연결할 채널 url
     * @return {} openChannel 채널 정보
     */
    getOpenChannel(url){
        if(url != null){
            this.channelUrl = url;
        }

        return new Promise((resolve, reject) => {
            this.sb.OpenChannel.getChannel(this.channelUrl, function(openChannel, error) {
                if(error) {
                    reject(error);
                } else {
                    openChannel.enter(function(response, error) {
                        if (error) {
                            reject(error);
                        } else {
                            resolve(openChannel);
                        }
                    });
                }
            });
        });
    }

    /**
     * 비공개 채널 연결 (인증된 사용자만 접근)
     *
     * @param {string} url 연결할 채널 url
     * @return {} openChannel 채널 정보
     */
    async getGroupChannel(url){
        if(url != null){
            this.channelUrl = url;
        }

        return await new Promise((resolve, reject) => {
            this.sb.GroupChannel.getChannel(this.channelUrl, function(groupChannel, error) {
                if (error) {
                    reject(error)
                } else {
                    resolve(groupChannel);
                }
            });
        }).then((groupChannel) => {
            this.channel = groupChannel;
            return groupChannel;
        })
    }

    /**
     * 채널 나가기
     *
     * @return {object} 성공 시 값
     */
    leaveChannel(){
        return new Promise((resolve, reject) => {
            this.getGroupChannel(null).then((channel) => {
                channel.leave(function(response, error) {
                    error ? reject(error) : resolve(response);
                });
            }).catch(error => {
                reject(error)
            });
        });
    }

    /**
     * 해당 채널의 메세지 이력
     *
     * @param {boolean} isInit 리스트 조회 초기화 여부
     * @param {number} limit 페이지 수
     * @param {boolean} reverse 역순 여부 결정
     * @return {array} messages 정보
     */
    async getList(isInit, limit, reverse) {
        if(this.channel == null){
            throw "There are no channels connected.";
        }

        if(listQuery == null || isInit){
            listQuery = this.channel.createPreviousMessageListQuery();
        }

        listQuery.limit = limit;
        listQuery.reverse = reverse;
        listQuery.includeMetaArray = true;  // Retrieve a list of messages along with their metaarrays.
        listQuery.includeReaction = true;   // Retrieve a list of messages along with their reactions.

        return await new Promise((resolve, reject) => {
            if(listQuery.hasMore && !listQuery.isLoading){
                listQuery.load(function(messages, error) {
                    if (error) {
                        reject(error);
                    } else {
                        resolve({ 'messages' : messages, isNext : listQuery.hasMore});
                    }
                });
            } else {
                reject("The following record does not exist.")
            }
        }).then((messages) => {
            return messages;
        });
    }

    unListQueryInit() {
        unListQuery = null;
    }

    async getUnList() {
        if(this.channel == null){
            throw "There are no channels connected.";
        }

        if(unListQuery == null){
            unListQuery = this.channel.createPreviousMessageListQuery();
        }

        unListQuery.limit = 100;
        unListQuery.reverse = true;
        unListQuery.includeMetaArray = true;  // Retrieve a list of messages along with their metaarrays.
        unListQuery.includeReaction = true;   // Retrieve a list of messages along with their reactions.

        return await new Promise((resolve, reject) => {
            if(unListQuery.hasMore && !unListQuery.isLoading){
                unListQuery.load(function(messages, error) {
                    if (error) {
                        reject(error);
                    } else {
                        resolve({ 'messages' : messages, isNext : unListQuery.hasMore});
                    }
                });
            } else {
                reject("The following record does not exist.")
            }
        });
    }

    /**
     * 메세지 전송
     *
     * @param {string} message 전송 메세지
     * @return {} message 정보
     */
    sendMessage(message) {
        const params = new this.sb.UserMessageParams();
        params.message = message;

        return new Promise((resolve, reject) => {
            this.getGroupChannel(null).then((channel) => {
                channel.sendUserMessage(params, function(message, error) {
                    error ? reject(error) : resolve(message);
                });
            }).catch(error => {
                reject(error)
            });
        });
    }

    /**
     * 파일 전송
     *
     * @param {object} file 첨부파일
     * @return {} fileMessage 정보
     */
    sendFileMessage(file) {
        return new Promise((resolve, reject) => {
            this.getGroupChannel(null).then((channel) => {
                channel.sendFileMessage(file, function(fileMessage, error) {
                    error ? reject(error) : resolve(fileMessage);
                });
            }).catch(error => {
                reject(error)
            });
        });
    }

    /**
     * 메세지에 대한 읽지 않은 수
     *
     * @param {object} message 메세지 object
     * @return {number} 읽지 않은 수
     */
    getUnreadCount(message) {
        if(this.channel == null){
            throw "There are no channels connected.";
        }

        return this.channel.getReadReceipt(message);
    }

    /**
     * 마지막 메세지
     *
     * @return {string} 마지막 메세지
     */
    getLastMessage() {
        return new Promise((resolve, reject) => {
            this.getGroupChannel(null).then((channel) => {
                resolve(channel.lastMessage)
            }).catch(error => {
                reject(error)
            });
        });
    }

    /**
     * 해당 채널의 읽지 않은 메세지 수
     *

     * @return {number} 읽지 않은 수
     */
    getChannelUnreadCount() {
        return new Promise((resolve, reject) => {
            this.getGroupChannel(null).then((channel) => {
                resolve(channel.unreadMessageCount)
            }).catch(error => {
                reject(error)
            });
        });
    }

    markAsRead() {
        return new Promise((resolve, reject) => {
            this.getGroupChannel(null).then((channel) => {
                channel.markAsRead().then(() => {
                    resolve();
                }).catch(err => {
                    reject(err)
                });
            }).catch(error => {
                reject(error)
            });
        });
    }
}

export default SendbirdAction;