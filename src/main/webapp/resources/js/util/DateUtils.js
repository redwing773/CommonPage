import commonUtils from "./CommonUtils.js";

class DateUtils {

    convertDefault(date) {
        const dateString = new Date(+date + 3240 * 10000).toISOString().split(
            "T")[0];
        const timeString = date.toTimeString().split(" ")[0];

        return dateString + ' ' + timeString;
    }

    convertKorean(date) {
        const year = date.getFullYear() + '년';
        const month = date.getMonth() + 1 + '월';
        const day = date.getDate() + '일';
        const week = '(' + this.convertDayNumberToKorean(date.getDay()) + ')';
        const hour = date.getHours() < 10 ? '0' + date.getHours()
            : date.getHours();
        const minute = date.getMinutes() < 10 ? '0' + date.getMinutes()
            : date.getMinutes();

        return year + ' ' + month + ' ' + day + ' ' + week + ' ' + ' ' + hour
            + ':' + minute;
    }

    convertDayNumberToKorean(week) {
        let weekKorean = '일';
        switch (week) {
            case 1:
                weekKorean = '월';
                break;
            case 2:
                weekKorean = '화';
                break;
            case 3:
                weekKorean = '수';
                break;
            case 4:
                weekKorean = '목';
                break;
            case 5:
                weekKorean = '금';
                break;
            case 6:
                weekKorean = '토';
                break;
        }

        return weekKorean;
    }

    convertStringToMillis(stringDate) {
        if (commonUtils.isEmpty(stringDate)) {
            return null;
        }

        return new Date(stringDate).getTime();
    }
}

const dateUtils = new DateUtils();

export default dateUtils;