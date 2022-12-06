#!/bin/bash
# Script to deploy a very simple web application.
# The web app has a customizable image and some text.

cat << EOM > /var/www/html/index.html

<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Clock</title>
    
    <style type="text/css">
        * {
    margin: 0;
    padding: 0;
    box-sizing: border-box;
}
:root {
    --color-green: #0fd996;
    --color-pink: #ff87ab;
    --color-blue: #0095ff;
}

/* ---------------------body design---------- */
body {
    min-height: 100vh;
    display: flex;
    justify-content: center;
    align-items: center;
}
body::before {
    content: "";
    position: absolute;
    top: 0;
    left: 0;
    width: 100%;
    height: 100%;
    background: linear-gradient(
        45deg,
        var(--color-green) 50%,
        var(--color-pink) 50%
    );
}
body::after {
    content: "";
    position: absolute;
    top: -20px;
    left: 0;
    width: 100%;
    height: 100%;
    background: linear-gradient(160deg, var(--color-blue) 50%, transparent 50%);
    animation: animate 4s ease-in-out infinite;
}

/* ------------------key frames------------- */
@keyframes animate {
    0%,
    100% {
        transform: translateY(10px);
    }
    50% {
        transform: translateY(-10px);
    }
}
/* --------------------container------------------- */
.container {
    position: relative;
}
.container::before {
    content: "";
    position: absolute;
    bottom: -115px;
    width: 100%;
    height: 60px;
    border-radius: 50%;
    background: radial-gradient(rgba(0, 0, 0, 0.3), transparent, transparent);
}
/* -------------------box design------------ */
.box {
    position: relative;
    z-index: 1;
    width: 400px;
    height: 400px;
    border-radius: 50%;
    backdrop-filter: blur(25px);
    border: 2px solid rgba(255, 255, 255, 0.2);
    animation: animate 5s ease-in-out infinite;
    animation-delay: -2.5s;
}
.clock {
    position: absolute;
    top: 10px;
    right: 10px;
    left: 10px;
    bottom: 10px;
    display: flex;
    justify-content: center;
    align-items: center;
    background: radial-gradient(transparent, rgba(255, 255, 255, 0.2)),
        url(data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAZAAAAGQCAYAAACAvzbMAAAAGXRFWHRTb2Z0d2FyZQBBZG9iZSBJbWFnZVJlYWR5ccllPAAAAyZpVFh0WE1MOmNvbS5hZG9iZS54bXAAAAAAADw/eHBhY2tldCBiZWdpbj0i77u/IiBpZD0iVzVNME1wQ2VoaUh6cmVTek5UY3prYzlkIj8+IDx4OnhtcG1ldGEgeG1sbnM6eD0iYWRvYmU6bnM6bWV0YS8iIHg6eG1wdGs9IkFkb2JlIFhNUCBDb3JlIDUuNi1jMDY3IDc5LjE1Nzc0NywgMjAxNS8wMy8zMC0yMzo0MDo0MiAgICAgICAgIj4gPHJkZjpSREYgeG1sbnM6cmRmPSJodHRwOi8vd3d3LnczLm9yZy8xOTk5LzAyLzIyLXJkZi1zeW50YXgtbnMjIj4gPHJkZjpEZXNjcmlwdGlvbiByZGY6YWJvdXQ9IiIgeG1sbnM6eG1wTU09Imh0dHA6Ly9ucy5hZG9iZS5jb20veGFwLzEuMC9tbS8iIHhtbG5zOnN0UmVmPSJodHRwOi8vbnMuYWRvYmUuY29tL3hhcC8xLjAvc1R5cGUvUmVzb3VyY2VSZWYjIiB4bWxuczp4bXA9Imh0dHA6Ly9ucy5hZG9iZS5jb20veGFwLzEuMC8iIHhtcE1NOkRvY3VtZW50SUQ9InhtcC5kaWQ6QzU5MEY0QkM0NjBGMTFFQkJFMDZCRDA1NDNENkM5MjQiIHhtcE1NOkluc3RhbmNlSUQ9InhtcC5paWQ6QzU5MEY0QkI0NjBGMTFFQkJFMDZCRDA1NDNENkM5MjQiIHhtcDpDcmVhdG9yVG9vbD0iQWRvYmUgUGhvdG9zaG9wIENDIDIwMTUgKFdpbmRvd3MpIj4gPHhtcE1NOkRlcml2ZWRGcm9tIHN0UmVmOmluc3RhbmNlSUQ9InhtcC5paWQ6Q0YyMzA4QjQ0NjBDMTFFQkFFNkNFNDczNTZDNURDN0YiIHN0UmVmOmRvY3VtZW50SUQ9InhtcC5kaWQ6Q0YyMzA4QjU0NjBDMTFFQkFFNkNFNDczNTZDNURDN0YiLz4gPC9yZGY6RGVzY3JpcHRpb24+IDwvcmRmOlJERj4gPC94OnhtcG1ldGE+IDw/eHBhY2tldCBlbmQ9InIiPz4Jt5OfAAARMElEQVR42uzd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);
    background-size: cover;
    border-radius: 50%;
    backdrop-filter: blur(25px);
    border: 2px solid rgba(255, 255, 255, 0.5);
    border-bottom: none;
    border-right: none;
    box-shadow: -10px -10px 20px rgba(255, 255, 255, 0.1),
        10px 10px 20px rgba(0, 0, 0, 0.1), 0px 20px 20px rgba(0, 0, 0, 0.1);
}
.clock::before {
    content: "";
    position: absolute;
    z-index: 1000;
    width: 15px;
    height: 15px;
    border-radius: 50%;
    background-color: #fff;
}
.hour,
.min,
.sec {
    position: absolute;
}
.hour,
.hr {
    width: 160px;
    height: 160px;
}

.min,
.mn {
    width: 190px;
    height: 190px;
}

.sec,
.sc {
    width: 230;
    height: 230px;
}

.hr,
.mn,
.sc {
    display: flex;
    justify-content: center;
    position: absolute;
    border-radius: 50%;
}
.hr::before {
    content: "";
    position: absolute;
    width: 8px;
    height: 50%;
    z-index: 11;
    background-color: var(--color-pink);
    border-radius: 6px;
}
.mn::before {
    content: "";
    position: absolute;
    width: 4px;
    height: 50%;
    z-index: 11;
    background-color: #fff;
    border-radius: 6px;
}
.sc::before {
    content: "";
    position: absolute;
    width: 2.5px;
    height: 65%;
    z-index: 11;
    background-color: var(--color-green);
    border-radius: 6px;
}

.h1{
  height: 50px;
  background-color: red; /* For browsers that do not support gradients */
  background-image: linear-gradient(yellow,lightgreen);
}

@media screen and (max-width: 678px) {
    .box {
        width: 300px;
        height: 300px;
    }
}
@media screen and (max-width: 290px) {
    .box {
        width: 250px;
        height: 250px;
    }
}


    </style>
</head>

<body>

    <div class="container">

        <div class="box">
            
            <div class="clock">
                <div class="hour">
                    <div class="hr" id="hr"></div>
                </div>
                <div class="min">
                    <div class="mn" id="mn"></div>
                </div>
                <div class="sec">
                    <div class="sc" id="sc"></div>
                </div>
            </div>
            <h1 class="h1">Welcome to ACME</h1>
        </div>
    </div>

    <script>
        
        const deg = 6;
        // getting the clock sticks
        const hr = document.getElementById("hr");
        const mn = document.getElementById("mn");
        const sc = document.getElementById("sc");
        setInterval(() => {
                            //system time
                            let day = new Date();
                            let hh = day.getHours() * 30;
                            let mm = day.getMinutes() * deg;
                            let ss = day.getSeconds() * deg;
                        
                            hr.style.transform = `rotateZ(${hh + mm / 12}deg)`;
                            mn.style.transform = `rotateZ(${mm}deg)`;
                            sc.style.transform = `rotateZ(${ss}deg)`;
                });

            </script>
</body>

</html>

EOM

echo "Script complete."
