function loadComments(post_id, user_id) {
    const data = {
        post_id: post_id,
        user_id: user_id
    }
    $.ajax({
        url: "load_comments.jsp",
        data: data,
        success: function (data, textStatus, jqXHR) {
            $("#load-comments-here").html(data);
//            console.log(data);
        },
        error: function (jqXHR, textStatus, errorThrown) {
            alert(textStatus + errorThrown);
        }
    });
}

function manageComments(post_id) {
    const data = {
        post_id: post_id
    };
    $.ajax({
        url: "manage_comments.jsp",
        data: data,
        success: function (data, textStatus, jqXHR) {
            $("#load-comments-here").html(data);
//            console.log(data);
        },
        error: function (jqXHR, textStatus, errorThrown) {
            alert(textStatus + errorThrown);
        }
    });
}


function loadCommentNo(post_id) {
    const data = {
        post_id: post_id
    };
    $.ajax({
        url: "no_of_comment.jsp",
        data: data,
        success: function (data, textStatus, jqXHR) {
            $("#comment-counter").html(data);
        },
        error: function (jqXHR, textStatus, errorThrown) {
            console.log(errorThrown);
        }
    });
}

//function loadLikesNo(post_id){
//    const data = {
//        post_id : post_id
//    };
//    $.ajax({
//       url:'no_of_likes.jsp',
//        data: data,
//        success: function (data, textStatus, jqXHR) {
//            $("#like-counter").html(data);
//        },
//        error: function (jqXHR, textStatus, errorThrown) {
//            console.log(errorThrown);
//        }
//    });
//}

function validateName() {
    let userName = $("#userName").val();
    let userNameMsg = $("#userName-msg");
    if (userName == '' || userName == undefined) {
        userNameMsg.html("Name is required !!").addClass("text-danger");
    } else {
        userNameMsg.html("").removeClass("text-danger");
        return true;
    }
    return false;
}

function validateEmail() {
    let email = $("#user_email").val();
    let emailMsg = $("#email-msg");
    let emailExp = /^\w+([\.-]?\w+)*@\w+([\.-]?\w+)*(\.\w{2,3})+$/;
    if (email == '' || email == undefined) {
        emailMsg.html("Email is required !!").addClass("text-danger");
    } else if (emailExp.test(email) == false) {
        emailMsg.html("Email must be in correct format , eg. tonystark@gmail.com").addClass("text-danger");
    } else {
        emailMsg.html("").removeClass("text-danger");
        return true;
    }
    return false;
}
function validatePassword() {
    let password = $("#user_password").val();
    let passwordExp = /^(?=.*\d)(?=.*[a-z])(?=.*[A-Z])(?=.*[^a-zA-Z0-9])(?!.*\s).{8,20}$/;
    let passwordMsg = $("#password-msg");
    if (password == '' || password == undefined) {
        passwordMsg.html("Password is required !!").addClass("text-danger");
    } else if (passwordExp.test(password) == false) {
        passwordMsg.html("Password must contain 1 Uppercase character , 1 Lowercase character, 1 digit, 1 special character and length must be 8 to 20").addClass("text-danger");
    } else {
        passwordMsg.html("").removeClass("text-danger");
        return true;
    }
    return false;
}

function validateGender() {
    let male = $("#genderMale");
    let female = $("#genderFemale");
    let genderMsg = $("#gender-msg");
    if (!male.is(":checked") && !female.is(":checked")) {
        genderMsg.html("Gender is required !!").addClass("text-danger");
    } else {
        genderMsg.html("").removeClass("text-danger");
        return true;
    }
    return false;
}

function validate() {

    let flag1 = false;
    flag1 = validateName();
    let flag2 = false;
    flag2 = validateEmail();
    let flag3 = false;
    flag3 = validatePassword();
    let flag4 = validateGender();

    let finalFlag = false;

    if (flag1 && flag2 && flag3 && flag4) {
        finalFlag = true;
    }
    return finalFlag;
}

function validateAdmin() {
    let flag1 = false;
    flag1 = validateName();
    let flag2 = false;
    flag2 = validateEmail();
    let flag3 = false;
    flag3 = validatePassword();

    let finalFlag = false;

    if (flag1 && flag2 && flag3) {
        finalFlag = true;
    }
    return finalFlag;
}

function updateTimeValidation() {
    let flag1 = false;
    flag1 = validateName();
    let flag2 = false;
    flag2 = validatePassword();

    let finalFlag = false;

    if (flag1 && flag2) {
        finalFlag = true;
    }
    return finalFlag;
}
