<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!doctype html>
<html lang="en">
    <head>
        <meta charset="utf-8">

        <title>Hipper</title>
        <meta name="description" content="Hipper Application">
        <meta name="author" content="Pim Plaatsman">
        <meta name="viewport" content="width=device-width, initial-scale=1">

        <link rel="stylesheet" href="<c:url value="resources/css/bootstrap.min.css"/>"/>
        <link rel="stylesheet" href="<c:url value="resources/css/main.css"/>"/>
        <link rel="stylesheet" href="<c:url value="resources/css/font-awesome.css"/>"/>
        
        <!--[if lt IE 9]>
        <script src="http://html5shiv.googlecode.com/svn/trunk/html5.js"></script>
        <![endif]-->
    </head>

    <body>

        <div class="container-fluid full-viewport">
            <div class="row full-hight main-container">
                <div id="refresh_cookies" class="btn btn-primary btn-sm">reset cookies</div>
                <div id="avatar" class="col-sm-3 avatar full-hight">
                    <img src="<c:url value="resources/img/doctor.png"/>" alt="Doctor">
                </div>
                <div  id="explanation" class="col-sm-4 full-hight">
                    <div class="bubble"></div>
                </div>
                <div  id="exercises" class="col-sm-5  full-hight">
                    <div class="exercise_container"> 
                        <h2>Oefeningen</h2>
                        <div class="exercise_board"> 


                            <div id="excercise_1" class="exercise active"> 
                                <div class="col-sm-12">
                                    <h3>Heup zijwaarts bewegen</h3> 
                                    <p>Duur: +/- 5 min</p>
                                    <i class="fa fa-check hide"></i>
                                </div> 
                            </div>

                            <div id="excercise_2" class="exercise "> 	
                                <div class="col-sm-12">
                                    <h3>Heup achterwaarts bewegen</h3> 
                                    <p>Duur: +/- 5 min</p>
                                    <i class="fa fa-check hide"></i>
                                </div> 
                            </div>

                            <div id="excercise_3" class="exercise "> 
                                <div class="col-sm-12">
                                    <h3>Buigen van de heup tot 90&deg;</h3> 
                                    <p>Duur: +/- 5 min</p>
                                    <i class="fa fa-check hide"></i>
                                </div> 
                            </div>

                            <div id="excercise_4" class="exercise "> 
                                <div class="col-sm-12">
                                    <h3>Knie strekken</h3> 
                                    <p>Duur: +/- 5 min</p>
                                    <i class="fa fa-check hide"></i>
                                </div>  
                            </div>

                            <div id="excercise_5" class="exercise "> 
                                <div class="col-sm-12">
                                    <h3>Zijwaarst stappen</h3> 
                                    <p>Duur: +/- 5 min</p>
                                    <i class="fa fa-check hide"></i>
                                </div> 
                            </div>

                        </div>
                    </div>
                </div>
            </div>
        </div>

        <!--script src="//ajax.googleapis.com/ajax/libs/jquery/2.1.0/jquery.min.js"></script-->
        <script src="<c:url value="resources/js/jquery.min.js"/>"></script>
        <script src="<c:url value="resources/js/bootstrap.min.js"/>"></script>
        <script type="text/javascript">

            function createCookie(name, value, days) {
                if (days) {
                    var date = new Date();
                    date.setTime(date.getTime() + (days * 24 * 60 * 60 * 1000));
                    var expires = "; expires=" + date.toGMTString();
                }
                else
                    var expires = "";
                document.cookie = name + "=" + value + expires + "; path=/";
            }

            function readCookie(name) {
                var nameEQ = name + "=";
                var ca = document.cookie.split(';');
                for (var i = 0; i < ca.length; i++) {
                    var c = ca[i];
                    while (c.charAt(0) == ' ')
                        c = c.substring(1, c.length);
                    if (c.indexOf(nameEQ) == 0)
                        return c.substring(nameEQ.length, c.length);
                }
                return null;
            }

            function eraseCookie(name) {
                createCookie(name, "", -1);
            }

            function ajaxLoad(el) {
                $(el).load(document.URL + el);
            }

            /* delete cookies */
            function delete_all_cookies() {
                console.log("deleting all cookies");
                eraseCookie('rehab_side');
                eraseCookie('excercise_1');
                eraseCookie('excercise_2');
                eraseCookie('excercise_3');
                eraseCookie('excercise_4');
                eraseCookie('excercise_5');
                location.reload();
            }


            function eddit_leg_welcome_text(leg) {
                new_welcome = welcome_text.replace('rehab_leg', leg);
                $(".bubble").empty();
                $(".bubble").append(new_welcome);
                check_exercises_done();
            }

            $('#refresh_cookies').click(function () {
                delete_all_cookies();
            });

            var Check_rehab_side = readCookie('rehab_side');
            var rehab_side = '';
            var rehab_leg = '';
            var welcome_text_rehab_side = "<p>" +
                    "Hallo!" +
                    "</br></br>" +
                    "Ik ben Maike, wij gaan samen " +
                    "oefeningen doen om de " +
                    "functies van de heup te " +
                    "verbeteren.</p>" +
                    "<p id=\"first_time\"> Omdat het uw eerste keer is " +
                    "wil ik graag weten welke heup " +
                    "u wilt gaan trainen." +
                    "</br></br>" +
                    "<p id=\"left_leg_togle\" class=\"btn btn-primary btn-lg\">Linker heup</p><p id=\"right_leg_togle\" class=\"btn btn-primary btn-lg\">Rechter heup</p>" +
                    "</br></br>" +
                    "</p>";

            var welcome_text = "<p>" +
                    "Bent u er klaar voor, om samen " +
                    "de oefeningen te doen? " +
                    "Druk op sensoren omdoen " +
                    "als u wilt beginnen.<br/><br/> " +
                    //"Of druk op de onderstaande knop " +
                    //"om direct te beginnen met het trainen " +
                    //"van uw rehab_leg heup." +
                    //"</br></br>" +
                    "<p id=\"plaats_Sensoren\" class=\"btn btn-primary btn-lg\">Sensoren omdoen</p>" +
                    //"</br></br>" +
                    "</p>";

            var welcome_text_2 = "<p>" +
                    "Bent u er klaar voor, om samen " +
                    "de oefeningen te doen? " +
                    "Druk op een oefening om te beginnen. " +
                    //"Of druk op de onderstaande knop " +
                    //"om direct te beginnen met het trainen " +
                    //"van uw rehab_leg heup." +
                    //"</br></br>" +
                    //"</br></br>" +
                    "</p>";

            var welcome_on_return_day = "<p id=\"returned_today\">" +
                    "Welkom terug!" +
                    "</br></br>" +
                    "Bent u er klaar voor, om samen " +
                    "de resterende oefeningen te doen?</p>" +
                    "Druk op verder om met de oefening" +
                    "verder te gaan waar u gestopt bent." +
                    "Of kies een oefening uit de lijst." +
                    "<p class=\"btn btn-primary btn-lg\">Verder</p>" +
                    "</p>";

            var video_instruction = "<div  id=\"videoInstruction\" class=\"col-sm-4 full-hight\">" +
                    "<video width=\"auto\" height=\"auto\" loop autoplay>" +
                    "<source src=\"./resources/video/oefening1.webm\" type=\"video/webm\">" +
                    "Your browser does not support the video tag." +
                    "</video>" +
                    "<p id=\"start_exercise\" class=\"btn btn-primary btn-lg\">Start Oefening</p>" +
                    "</div>";

            ///////........    Exercice page    ........///////
            var exercise_instruction_container = "<div id=\"explanation_exercise\"  class=\"col-sm-3 avatar full-hight\"></div>";

            var exercise_video_container = "<div  id=\"videoInstruction\" class=\"col-sm-6 full-hight\">" +
                    "<video id=\"instructionVideo\" width=\"100%\" height=\"auto\" onended=\"videoEnded()\">" +
                    "<source src=\"./resources/video/oefening1.webm\" type=\"video/webm\">" +
                    "Your browser does not support the video tag." +
                    "</video>" +
                    "<div id=\"videoElements\">" +
                    "<div id=\"start\" class=\"videoButtons\"><p>Start video</p><i class=\"fa fa-play\"></i></div>" +
                    "<div id=\"pause\" class=\"videoButtons hide pauze\"><p>Pauzeer video</p><i class=\"fa fa-pause\"></i></div>" +
                    "</div>" +
                    "<div id=\"repetitionCounter\">" +
                    "<div class=\"circle\" ></div>" +
                    "<div class=\"circle\" ></div>" +
                    "<div class=\"circle\" ></div>" +
                    "<div class=\"circle\" ></div>" +
                    "<div class=\"circle\" ></div>" +
                    "<div class=\"circle\" ></div>" +
                    "<div class=\"circle\" ></div>" +
                    "<div class=\"circle\" ></div>" +
                    "<div class=\"circle\" ></div>" +
                    "<div class=\"circle\" ></div>" +
                    "<i class=\"fa fa-star-o\"></i>" +
                    "</div>" +
                    "</div>";

            var exercise_statistics_container = "<div  id=\"statistics\" class=\"col-sm-3  full-hight\">" +
                    "<div class=\"avatar\">" +
                    "<div id=\"feedback\" class=\"bubble left hide\"><br> </p></div>" +
                    "<img src=\"./resources/img/AvatarDoctor.png\" alt=\"AvatarDoctor\">" +
                    "</div>" +
                    "<div id=\"countdown\">" +
                    "<h3>Aantal herhalingen te gaan:</h3>" +
                    "<p class=\"counter\">10</p>" +
                    "</div>" +
                    "<div style=\"height:50px;\"></div>" +
                    "<div id=\"speed\">" +
                    "<p>Verander de snelheid van de oefening</p>" +
                    "<a id=\"speedUp\" class=\"btn btn-lg btn-danger\">Sneller</a>" +
                    "<a id=\"speedDown\" class=\"btn btn-lg btn-success\">Langzamer</a>" +
                    "</div>" +
                    "<div> <div id=\"BackHome\" class=\"btn btn-primary btn-lg\"><i class=\"fa fa-home\"></i> terug naar de oefeningen</div>" +
                    "</div>";

            ///////........    EO Exercice page    ........///////

            /* the excercise objects  */

            var excercise_1 = new Object();
            excercise_1.Long_name = "Heup zijwaarts bewegen";
            excercise_1.name = "Heup Zijwaarts";
            excercise_1.explanation = "<span id=\"rep_span\"> Sets: 3 </br>" +
                    "Herhalingen: 10 </br></br></span>" +
                    "Houding: Neem met uw goede been plaats naast een object die steun aan u kan verlenen zoals een tafelblad, stoel of bank.</br></br>" +
                    "Oefening: Beweeg het geopereerde been in zijwaartse richting en hou dit " +
                    "even vast. Doe dit alleen met het geopereerde been! Probeer er hierbij op " +
                    "te letten dat uw tenen naar voren wijzen, de knie gestrekt is en het bovenlichaam recht blijft. </br></br>"+
                    "Doel van de oefening: Het verbeteren van de bewegelijkheid en de spierkracht van het " +
                    "geopereerde been. Dit is van belang tijdens het lopen.";

            var excercise_2 = new Object();
            excercise_2.Long_name = "Heup achterwaarts bewegen";
            excercise_2.name = "Heup Achterwaarts";
            excercise_2.explanation = "<span id=\"rep_span\">Sets: 3 </br>" +
                    "Herhalingen: 10 </br></br></span>" +
                    "Houding: Neem met uw goede been plaats naast een object dat steun aan u kan verlenen zoals een tafelblad, stoel of bank.</br></br>" +
                    "Oefening: Beweeg het been naar achteren tot zover dit mogelijk is, probeer hierbij te letten dat u het bekken en het bovenlichaam recht houdt.</br></br>"+
                    "Doel van de oefening: Het vergroten/behouden van de bewegelijkheid en de kracht van de heupspieren.";

            var excercise_3 = new Object();
            excercise_3.Long_name = "Buigen van de heup tot 90&deg;";
            excercise_3.name = "Buig Heup";
            excercise_3.explanation = "Houding: Neem met uw goede been plaats naast een object dat steun aan u kan verlenen zoals een tafelblad, stoel of bank.</br></br>" +
                    "Oefening: Trek uw knie omhoog zodat de heup en knie een hoek maken van 90 graden. Let op deze hoek mag niet groter worden dan 90 graden!</br></br>"+
                    "Doel van de oefening: Het vergroten/behouden van de bewegelijkheid en de kracht van de heupspieren.";

            var excercise_4 = new Object();
            excercise_4.Long_name = "Knie Strekken";
            excercise_4.name = "Knie Strekken";
            excercise_4.explanation = "Houding: Ga op een hoge stoel zitten met beide voeten plat op de grond.</br></br>" +
                    "Oefening: Strek u knie van het aangedane been en laat hem dan weer rustig buigen naar de beginpositie.</br></br>"+
                    "Doel van de oefening: Het verbeteren van de kracht van de voorste dijbeenspieren.";


            var excercise_5 = new Object();
            excercise_5.Long_name = "Zijwaarst stappen";
            excercise_5.name = "Stap Zijwaarts";
            excercise_5.explanation = "<span id=\"rep_span\">Sets: 4 </br>" +
                    "Herhalingen: 12 </br></br></span>" +
                    "Houding: Ga rechtop staan en zorg voor voldoende ruimte om u heen.</br></br>" +
                    "Oefening: U loopt 5 stappen zijwaarts. Vervolgens loopt u weer 5 " +
                    "stappen zijwaarts terug waarbij u met uw gezicht dezelfde kant op " +
                    "blijft kijken. Let erop dat u uw bovenlichaam stil houdt tijdens de oefening.</br></br>"+
                    "Doel van de oefening: Het verbeteren van de spierkracht van de zijwaartse heupspieren.";


            /* EO the excercise objects  */

            if (Check_rehab_side === null) {

                if ($(".bubble").html().length < 5) {
                    $(".bubble").append(welcome_text_rehab_side);
                }

                $('#left_leg_togle').click(function () {
                    createCookie('rehab_side', 'Left', 30);
                    rehab_leg = "linker";
                    rehab_side = "Links";
                    eddit_leg_welcome_text(rehab_leg);

                    $(".exercise_container h2").append(' linker been');
                });
                $('#right_leg_togle').click(function () {
                    createCookie('rehab_side', 'Right', 30);
                    rehab_leg = "rechter";
                    rehab_side = "Rechts";
                    eddit_leg_welcome_text(rehab_leg);
                    $(".exercise_container h2").append(' rechter been');
                });


            } else {
                if (Check_rehab_side === 'Left') {
                    $(".exercise_container h2").append(' linker been');
                    rehab_leg = "linker";
                    rehab_side = "Links";
                }
                if (Check_rehab_side === 'Right') {
                    $(".exercise_container h2").append(' rechter been');
                    rehab_leg = "rechter";
                    rehab_side = "Rechts";
                }

                if ($(".bubble").html().length < 5) {
                    new_welcome = welcome_text.replace('rehab_leg', rehab_leg);
                    $(".bubble").append(new_welcome);
                }

            }

            $('#plaats_Sensoren').click(function () {

                $(".bubble").empty();
                $(".bubble").append("<p>Plaats de sensoren zoals op het onderstaande voorbeeld op de aangegeven plek; borst, bovenbeen en onderbeen." +
                        "</br>Zorg dat de sensoren aan de voorkant van het lichaam zitten.</br></br>" +
                        "Als alles goed zit druk dan op verbinden. </p><img src=\"http://review.opjeplaatsman.nl/img/connecting.png\"></br>" +
                        "<p id=\"Verbinden\"class=\"btn btn-primary btn-lg\">Verbinden</p>");

                $('#Verbinden').click(function () {

                    $(".bubble").empty();
                    $(".bubble").append("<p>De sensoren zijn verbonden. </br>" +
                            "Druk op een van de oefeningen om te beginnen. </br>" +
                            "<img src=\"http://review.opjeplaatsman.nl/img/connected.png\">");
                });
            });



            var exercise_explanation = "";
            var exercise_video;
            var current_exercise_id;

            $('#excercise_1').click(function () {
                current_exercise_id = $(this).attr('id');
                exercise_explanation = "<h2>" + excercise_1.Long_name + "</h2>" +
                        "<p>" + excercise_1.explanation + "</p>";
                $(".bubble").empty();
                $(".bubble").append(exercise_explanation);
                $("#exercises").addClass("hide");
                $(".row").append(video_instruction);
                exercise_video = './resources/video/' + excercise_1.name + ' ' + rehab_side + '.mp4';
                $("video source").attr('src', exercise_video);
                load_exercise_screen();
            });


            $('#excercise_2').click(function () {
                current_exercise_id = $(this).attr('id');
                exercise_explanation = "<h2>" + excercise_2.Long_name + "</h2>" +
                        "<p>" + excercise_2.explanation + "</p>";
                $(".bubble").empty();
                $(".bubble").append(exercise_explanation);
                $("#exercises").addClass("hide");
                $(".row").append(video_instruction);
                exercise_video = './resources/video/' + excercise_2.name + ' ' + rehab_side + '.mp4';
                $("video source").attr('src', exercise_video);
                load_exercise_screen();
            });


            $('#excercise_3').click(function () {
                current_exercise_id = $(this).attr('id');
                exercise_explanation = "<h2>" + excercise_3.Long_name + "</h2>" +
                        "<p>" + excercise_3.explanation + "</p>";
                $(".bubble").empty();
                $(".bubble").append(exercise_explanation);
                $("#exercises").addClass("hide");
                $(".row").append(video_instruction);
                exercise_video = './resources/video/' + excercise_3.name + ' ' + rehab_side + '.mp4';
                $("video source").attr('src', exercise_video);
                load_exercise_screen();
            });

            $('#excercise_4').click(function () {
                current_exercise_id = $(this).attr('id');
                exercise_explanation = "<h2>" + excercise_4.Long_name + "</h2>" +
                        "<p>" + excercise_4.explanation + "</p>";
                $(".bubble").empty();
                $(".bubble").append(exercise_explanation);
                $("#exercises").addClass("hide");
                $(".row").append(video_instruction);
                exercise_video = './resources/video/' + excercise_4.name + ' ' + rehab_side + '.mp4';
                $("video source").attr('src', exercise_video);
                load_exercise_screen();
            });

            $('#excercise_5').click(function () {
                current_exercise_id = $(this).attr('id');
                exercise_explanation = "<h2>" + excercise_5.Long_name + "</h2>" +
                        "<p>" + excercise_5.explanation + "</p>";
                $(".bubble").empty();
                $(".bubble").append(exercise_explanation);
                $("#exercises").addClass("hide");
                $(".row").append(video_instruction);
                exercise_video = './resources/video/' + excercise_5.name + ' ' + rehab_side + '.mp4';
                $("video source").attr('src', exercise_video);
                load_exercise_screen();
            });



            ///////........    Exercice page    ........///////

            function load_exercise_screen() {
                $("#explanation").removeClass("col-sm-4");
                $("#explanation").addClass("col-sm-5");
                $("#refresh_cookies").addClass("hide");

                $('#start_exercise').click(function () {

                    $(".bubble").empty();
                    $(".bubble").append(welcome_text_2);
                    $("#explanation").addClass("hide");
                    $("#avatar").addClass("hide");
                    $("#videoInstruction").remove();

                    $(".main-container").append(exercise_instruction_container);
                    $(".main-container").append(exercise_video_container);
                    $(".main-container").append(exercise_statistics_container);

                    $("#explanation_exercise").append(exercise_explanation);
                    console.log("check explanation : " + exercise_explanation);
                    console.log($("#explanation_exercise"));
                    $("video source").attr('src', exercise_video);

                    video_controls();
                    $("#feedback").removeClass("hide");
                    $("#feedback").empty();
                    $("#feedback").append("Als je er klaar voor bent druk dan op 'Start video' om te beginnen");
                });
            }


            function check_exercises_done() {
                console.log("getting to check_exercises_done");
                var excercise_1_cooky = readCookie('excercise_1');
                var excercise_2_cooky = readCookie('excercise_2');
                var excercise_3_cooky = readCookie('excercise_3');
                var excercise_4_cooky = readCookie('excercise_4');
                var excercise_5_cooky = readCookie('excercise_5');
                var exercises_done = 0;

                if (excercise_1_cooky === 'done fot today') {
                    $("#excercise_1 i").removeClass("hide");
                    exercises_done++;
                }
                if (excercise_2_cooky === 'done fot today') {
                    $("#excercise_2 i").removeClass("hide");
                    exercises_done++;
                }
                if (excercise_3_cooky === 'done fot today') {
                    $("#excercise_3 i").removeClass("hide");
                    exercises_done++;
                }
                if (excercise_4_cooky === 'done fot today') {
                    $("#excercise_4 i").removeClass("hide");
                    exercises_done++;
                }
                if (excercise_5_cooky === 'done fot today') {
                    $("#excercise_5 i").removeClass("hide");
                    exercises_done++;
                }

                if (exercises_done > 0) {
                    var excersises_left = 5 - exercises_done;
                    $(".bubble").empty();
                    $(".bubble").append("<p>Goed bezig! we hebben nog " + excersises_left + " oefeningen te doen en dan zijn we klaar voor vandaag! </br></br> Ga zo Door!</p>");
                    if (excersises_left == 0) {
                        $(".bubble").empty();
                        $(".bubble").append("<p>Goed bezig! we hebben alle oefeningen gedaan, we zijn klaar voor vandaag! Je kan de sensoren weer af doen. </br></br>Tot morgen!</p>");
                    }
                }

            }


            var videoSpeed = 1.0;
            var Repetitions = 0;
            var TotalReps = 10;

            function video_controls() {

                $('#start').click(function () {
                    $(this).addClass("hide");
                    $("#pause").removeClass("hide");
                    document.getElementById("instructionVideo").play();
                    $("#feedback").addClass("hide");
                });
                $('#pause').click(function () {
                    $(this).addClass("hide");
                    $("#start").removeClass("hide");
                    document.getElementById("instructionVideo").pause();
                });

                $('#speedUp').click(function () {
                    if (!(videoSpeed > 3.0)) {
                        videoSpeed += 0.5;
                        console.log("videoSpeed= " + videoSpeed);
                        document.getElementById("instructionVideo").playbackRate = videoSpeed;
                    }
                });
                $('#speedDown').click(function () {
                    if (!(videoSpeed < 1.0)) {
                        videoSpeed -= 0.5;
                        console.log("videoSpeed= " + videoSpeed);
                        document.getElementById("instructionVideo").playbackRate = videoSpeed;
                    }
                });

                $('#BackHome').click(function () {
                    BackToHome();
                });

            }

            function BackToHome() {
                $("#exercises").removeClass("hide");
                $("#avatar").removeClass("hide");
                $("#explanation").removeClass("hide");

                $("#explanation").removeClass("col-sm-5");
                $("#explanation").addClass("col-sm-4");

                $("#explanation_exercise").remove();
                $("#videoInstruction").remove();
                $("#statistics").remove();
                console.log("BackToHome rehab leg = " + rehab_leg);
                eddit_leg_welcome_text(rehab_leg);

                videoSpeed = 1.0;
                Repetitions = 0;
                TotalReps = 10;
                check_exercises_done();
                $("#refresh_cookies").removeClass("hide");
            }

            function videoEnded() {
                Repetitions++;
                var repsToGo = TotalReps - Repetitions;
                var circleElement = ".circle:nth-child(" + Repetitions + ")";

                console.log('Repetitions = ' + Repetitions);
                $('#instructionVideo')[0].play();
                $(circleElement).addClass('green');
                $(".counter").html(repsToGo);

                if (Repetitions % 3 == 0) {
                    $("#feedback").empty();
                    $("#feedback").append("<p>Goed bezig! ga zo door!<br> <i class=\"fa fa-thumbs-up\"></i>");
                    $("#feedback").removeClass("hide");
                } else {
                    $("#feedback").addClass("hide");
                }

                if (Repetitions == 10) {
                    $("#feedback").empty();
                    $("#feedback").append("Goed Gedaan we zijn klaar met de oefening! Druk op 'terug naar de oefeningen' om verder te gaan.");
                    $("#feedback").removeClass("hide");
                    $('.fa.fa-star-o').removeClass("fa-star-o").addClass('fa-star');
                    document.getElementById("instructionVideo").pause();
                    $("#pause").addClass("hide");
                    $("#start").removeClass("hide");
                    createCookie(current_exercise_id, 'done fot today', 1);
                }

            }

        </script>


    </body>

</html>
