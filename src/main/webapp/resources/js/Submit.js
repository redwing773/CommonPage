let isClick = false;

class Submit {

    isDuplicateRequest() {
        if(isClick) {
            return isClick;
        } else {
            isClick = true;
            setTimeout(function(){
                isClick = false;
            }, 500);
            return !isClick;
        }
    }
}

const submit = new Submit();

export default submit;