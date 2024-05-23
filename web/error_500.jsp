<%-- 
    Document   : error_500
    Created on : 18 Sep, 2023, 10:08:49 PM
    Author     : vishal
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page isErrorPage="true"%>
<!DOCTYPE html>
<html lang="en">

    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Sorry ! something went wrong</title>
    </head>
    <style>
        html,
        body {
            height: 100%;
        }
        body {
            display: grid;
            width: 100%;
            font-family: Inconsolata, monospace;
        }
        body div#error {
            position: relative;
            margin: auto;
            padding: 20px;
            z-index: 2;
        }
        body div#error div#box {
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            border: 1px solid #000;
        }
        body div#error div#box:before,
        body div#error div#box:after {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            box-shadow: inset 0px 0px 0px 1px #000;
            mix-blend-mode: multiply;
            animation: dance 2s infinite steps(1);
        }
        body div#error div#box:before {
            clip-path: polygon(0 0, 65% 0, 35% 100%, 0 100%);
            box-shadow: inset 0px 0px 0px 1px currentColor;
            color: #f0f;
        }
        body div#error div#box:after {
            clip-path: polygon(65% 0, 100% 0, 100% 100%, 35% 100%);
            animation-duration: 0.5s;
            animation-direction: alternate;
            box-shadow: inset 0px 0px 0px 1px currentColor;
            color: #0ff;
        }
        body div#error h3 {
            position: relative;
            font-size: 5vw;
            font-weight: 700;
            text-transform: uppercase;
            animation: blink 1.3s infinite steps(1);
        }
        body div#error h3:before,
        body div#error h3:after {
            content: 'ERROR 500';
            position: absolute;
            top: -1px;
            left: 0;
            mix-blend-mode: soft-light;
            animation: dance 2s infinite steps(2);
        }
        body div#error h3:before {
            clip-path: polygon(0 0, 100% 0, 100% 50%, 0 50%);
            color: #f0f;
            animation: shiftright 200ms steps(2) infinite;
        }
        body div#error h3:after {
            clip-path: polygon(0 100%, 100% 100%, 100% 50%, 0 50%);
            color: #0ff;
            animation: shiftleft 200ms steps(2) infinite;
        }
        body div#error p {
            position: relative;
            margin-bottom: 8px;
        }
        body div#error p span {
            position: relative;
            display: inline-block;
            font-weight: bold;
            color: #000;
            animation: blink 3s steps(1) infinite;
        }
        body div#error p span:before,
        body div#error p span:after {
            content: 'unstable';
            position: absolute;
            top: -1px;
            left: 0;
            mix-blend-mode: multiply;
        }
        body div#error p span:before {
            clip-path: polygon(0 0, 100% 0, 100% 50%, 0 50%);
            color: #f0f;
            animation: shiftright 1.5s steps(2) infinite;
        }
        body div#error p span:after {
            clip-path: polygon(0 100%, 100% 100%, 100% 50%, 0 50%);
            color: #0ff;
            animation: shiftleft 1.7s steps(2) infinite;
        }
        @-moz-keyframes dance {
            0%, 84%, 94% {
                transform: skew(0deg);
            }
            85% {
                transform: skew(5deg);
            }
            90% {
                transform: skew(-5deg);
            }
            98% {
                transform: skew(3deg);
            }
        }
        @-webkit-keyframes dance {
            0%, 84%, 94% {
                transform: skew(0deg);
            }
            85% {
                transform: skew(5deg);
            }
            90% {
                transform: skew(-5deg);
            }
            98% {
                transform: skew(3deg);
            }
        }
        @-o-keyframes dance {
            0%, 84%, 94% {
                transform: skew(0deg);
            }
            85% {
                transform: skew(5deg);
            }
            90% {
                transform: skew(-5deg);
            }
            98% {
                transform: skew(3deg);
            }
        }
        @keyframes dance {
            0%, 84%, 94% {
                transform: skew(0deg);
            }
            85% {
                transform: skew(5deg);
            }
            90% {
                transform: skew(-5deg);
            }
            98% {
                transform: skew(3deg);
            }
        }
        @-moz-keyframes shiftleft {
            0%, 87%, 100% {
                transform: translate(0, 0) skew(0deg);
            }
            84%, 90% {
                transform: translate(-8px, 0) skew(20deg);
            }
        }
        @-webkit-keyframes shiftleft {
            0%, 87%, 100% {
                transform: translate(0, 0) skew(0deg);
            }
            84%, 90% {
                transform: translate(-8px, 0) skew(20deg);
            }
        }
        @-o-keyframes shiftleft {
            0%, 87%, 100% {
                transform: translate(0, 0) skew(0deg);
            }
            84%, 90% {
                transform: translate(-8px, 0) skew(20deg);
            }
        }
        @keyframes shiftleft {
            0%, 87%, 100% {
                transform: translate(0, 0) skew(0deg);
            }
            84%, 90% {
                transform: translate(-8px, 0) skew(20deg);
            }
        }
        @-moz-keyframes shiftright {
            0%, 87%, 100% {
                transform: translate(0, 0) skew(0deg);
            }
            84%, 90% {
                transform: translate(8px, 0) skew(20deg);
            }
        }
        @-webkit-keyframes shiftright {
            0%, 87%, 100% {
                transform: translate(0, 0) skew(0deg);
            }
            84%, 90% {
                transform: translate(8px, 0) skew(20deg);
            }
        }
        @-o-keyframes shiftright {
            0%, 87%, 100% {
                transform: translate(0, 0) skew(0deg);
            }
            84%, 90% {
                transform: translate(8px, 0) skew(20deg);
            }
        }
        @keyframes shiftright {
            0%, 87%, 100% {
                transform: translate(0, 0) skew(0deg);
            }
            84%, 90% {
                transform: translate(8px, 0) skew(20deg);
            }
        }
        @-moz-keyframes blink {
            0%, 50%, 85%, 100% {
                color: #000;
            }
            87%, 95% {
                color: transparent;
            }
        }
        @-webkit-keyframes blink {
            0%, 50%, 85%, 100% {
                color: #000;
            }
            87%, 95% {
                color: transparent;
            }
        }
        @-o-keyframes blink {
            0%, 50%, 85%, 100% {
                color: #000;
            }
            87%, 95% {
                color: transparent;
            }
        }
        @keyframes blink {
            0%, 50%, 85%, 100% {
                color: #000;
            }
            87%, 95% {
                color: transparent;
            }
        }
        .box .box__description .box__button {
            display: block;
            position: relative;
            background: #9768D9;
            border: 1px solid transparent;
            border-radius: 50px;
            height: 50px;
            text-align: center;
            text-decoration: none;
            color: #fff;
            line-height: 50px;
            font-size: 18px;
            padding: 0 70px;
            white-space: nowrap;
            margin-top: 25px;
            transition: background 0.5s ease;
            overflow: hidden;
            -webkit-mask-image: -webkit-radial-gradient(white, black);
        }

        .box .box__description .box__button:before {
            content: "";
            position: absolute;
            width: 20px;
            height: 100px;
            background: #fff;
            bottom: -25px;
            left: 0;
            border: 2px solid #fff;
            transform: translateX(-50px) rotate(45deg);
            transition: transform 0.5s ease;
        }

        .box .box__description .box__button:hover {
            background: #BFB9FA;
            border-color: #BFB9FA;
            color:#773141;
        }

        .box .box__description .box__button:hover:before {
            transform: translateX(250px) rotate(45deg);
        }

    </style>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css"
          rel="stylesheet"
          integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC"
          crossorigin="anonymous">
    <link href="css/mystyle.css" rel="stylesheet" type="text/css" />
    <body>

        <div id="error">
            <div id="box"></div>
            <h3>ERROR 500</h3>
            <p>Things are a little <span>unstable</span> here</p>
            <p>Internal server error,I suggest come back later</p>
            <div class="d-flex justify-content-center align-items-center">
                <div class="box">
                    <div class="box__description">
                        <button id="redirectButton" class="box__button">Go Back</button>
                    </div>
                </div>

            </div>
        </div>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.7.0/jquery.min.js"
                        integrity="sha512-3gJwYpMe3QewGELv8k/BX9vcqhryRdzRMxVfq6ngyWXwo03GFEzjsUm8Q7RZcHPHksttq7/GFoxjCVUjkjvPdw=="
                crossorigin="anonymous" referrerpolicy="no-referrer"></script>
        <script>
            $("#redirectButton").on("click", function () {
                window.history.back();
            });
        </script>
    </body>

</html>