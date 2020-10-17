// Define study
const study = lab.util.fromObject({
  "title": "root",
  "type": "lab.flow.Sequence",
  "parameters": {},
  "plugins": [
    {
      "type": "lab.plugins.Metadata"
    },
    {
      "type": "lab.plugins.Transmit",
      "url": "backend.php"
    }
  ],
  "metadata": {
    "title": "",
    "description": "",
    "repository": "",
    "contributors": ""
  },
  "responses": {},
  "content": [
    {
      "type": "lab.html.Screen",
      "parameters": {},
      "responses": {
        "keypress(Space)": "continue"
      },
      "messageHandlers": {},
      "title": "Welcome",
      "content": "\u003Cheader\u003E\n  \u003Ch1\u003EWelcome to the Necker cube study on attention processes\u003C\u002Fh1\u003E\n\u003C\u002Fheader\u003E\n\n\u003Cmain class=\"content-vertical-center content-horizontal-center\"\u003E\n  \u003Cdiv class=\"w-m text-justify\"\u003E\n    \u003Cp\u003EThis study investigates attention processeses.\u003C\u002Fp\u003E\n    \u003Cp\u003EThis study is part of ongoing research activities \n      of the department of psychology at the FOM university.\n      The principal investigator is Professor \u003Ca href=\"mailto:sebastian.sauer@fom.de\"\u003ESebastian Sauer\u003C\u002Fa\u003E. \n      Please contact him for any questions. \n      Your participation supports the research about mental processing.\n      \u003C\u002Fp\u003E\n\n  \u003Cp\u003E\n    Principal investigator: \u003Cbr\u003E\n    Professor Sebastian Sauer \u003C\u002Fbr\u003E\n    FOM University \u003Cbr\u003E\n    email: sebastian.sauer@fom.de \u003Cbr\u003E\n    url: \u003Ca href=\"https:\u002F\u002Fwww.fom.de\u002Fforschung\u002Finstitute\u002Fiwp.html\"\u003E \n    https:\u002F\u002Fwww.fom.de\u002Fforschung\u002Finstitute\u002Fiwp.html \u003C\u002Fa\u003E\n  \u003C\u002Fp\u003E\n\n      \u003Cp\u003EFor more information on the study,\n      please press the \u003Ckbd\u003ESpace\u003C\u002Fkbd\u003E bar to continue.\u003C\u002Fp\u003E\n  \u003C\u002Fdiv\u003E\n\u003C\u002Fmain\u003E\n\n\n\u003Cfooter\u003E\n  Please press \u003Ckbd\u003Espace\u003C\u002Fkbd\u003E\n  to proceed to the participants' instructions for this study.\n\u003C\u002Ffooter\u003E"
    },
    {
      "type": "lab.html.Screen",
      "parameters": {},
      "responses": {
        "keypress(Space)": "continue"
      },
      "messageHandlers": {},
      "title": "Consent",
      "content": "\u003Cheader\u003E\n  \u003Ch1\u003EInformed Consent\u003C\u002Fh1\u003E\n\u003C\u002Fheader\u003E\n\n\n\n\n\u003Cmain class=\"content-vertical-center content-horizontal-center\"\u003E\n  \u003Cdiv class=\"w-m text-justify\"\u003E\n   \n      \u003Cp\u003E\n      We are conducting this web-based study in order to investigate\n      mental processes using bistabile images \n      (see next page for an example). \n      You will see an image on the screen \n      and you will be asked to press a button according to your \n      perception of the image.\n      \u003C\u002Fp\u003E\n\n      \u003Cp\u003E\n      \u003Cstrong\u003E Before participating it is important that you \n        understand what your participation would involve. \n        Please take time to read the following information carefully.  \u003C\u002Fstrong\u003E\n      \u003C\u002Fp\u003E\n\n      \u003Cp\u003E\n      In order to participate, you must be 18 years or older. \n      There are special incentives to participate in the study.\n      \u003C\u002Fp\u003E\n   \n      \u003Cp\u003E\n      Your participation in this study is completely voluntary \n      and you may withdraw at any time without penalty. \n      If you choose to participate, \n      it will take approximately 5-10 minutes of your time.\n      \u003C\u002Fp\u003E\n\n      \u003Cp\u003E    \n      Your privacy and safety will be respected at all times. \n      Participants will not be identified by the data collected.\n      Please do not enter \n      any information that may de-anonymize yourself \n      (such as email adresses). \n      Contact details will be repeated on the last page, so\n      that you can contact us for any question regarding the study.\n      \u003C\u002Fp\u003E\n    \n      \u003Cp\u003E\n      There are none known potential consequences of participating\n      in the study; potential risks, \n      adverse side effects or discomfort is not to be expected.\n      Participants do not have to answer all questions asked of them \n      and can stop their participation at any time\n      \u003C\u002Fp\u003E\n\n      \u003Cp\u003E\n      Data (anonymous) will be stored for research purposes \n      for an indefinite period of time. \n      It is planned to provide the data openly so that other researcher\n      may use them for subsequent research.\n      \u003C\u002Fp\u003E\n\n      \u003Cp\u003E\n      You are free to withdraw from the research study \n      at any time without explanation, disadvantage or consequence. \n      However, if you withdraw I would reserve the right to use \n      Material that you provide up until \n      the point of my analysis of the data. \n      \u003C\u002Fp\u003E\n\n      \u003Cp\u003E By clicking you confirm that you have read and understood \n       the information provided above. If you agree to participate, \n      please hit the \u003Ckbd\u003ESpace\u003C\u002Fkbd\u003E bar.\u003C\u002Fp\u003E\n\n    \u003C\u002Fdiv\u003E\n\n\u003C\u002Fmain\u003E\n\n\n\n\u003Cfooter\u003E\n  Please press \u003Ckbd\u003Espace\u003C\u002Fkbd\u003E\n  to proceed to the instructions for this study.\n\u003C\u002Ffooter\u003E"
    },
    {
      "type": "lab.html.Screen",
      "parameters": {},
      "responses": {
        "keypress(Space)": "continue"
      },
      "messageHandlers": {},
      "title": "Necker Cube",
      "content": "\u003Cheader\u003E\n  \u003Ch1\u003EThe \"Necker Cube\" - main research object of this study\u003C\u002Fh1\u003E\n\u003C\u002Fheader\u003E\n\n\n\n\n\u003Cmain class=\"content-vertical-center content-horizontal-center\"\u003E\n  \u003Cdiv class=\"w-m text-justify\"\u003E\n    \u003Cp\u003EBelow you can seee the wire-frame \"Necker Cube\" (upper panel).\n     \n      If you look ath the cube long enough, \n      it will seem to \"flip\" between patterns.\n      These two patterns are depicted in the lower panel.\n      \u003C\u002Fp\u003E\n\n      \u003Cp\u003E Test it: Concentrate on the cube (upper panel) until your perception flips.\u003C\u002Fp\u003E\n\n      \u003Cp\u003E Your task will be to concentrate on the cube, \n        hitting the space key \n        \u003Cemph\u003Eeach time\u003C\u002Femph\u003E and \u003Cemph\u003E as soon as\u003C\u002Femph\u003E your perception flips.\u003C\u002Fp\u003E\n\n      \u003Cp\u003E It does not matter wheter it flips from this to that perception,\n        or from that to this perception. \n        It does not matter how long it takes until it flips. \n        Just hit the space bar whenever a flip occurs.\n      \u003C\u002Fp\u003E\n\n  \u003C\u002Fmain\u003E\n\n\n\u003Cmain class=\"content-vertical-center content-horizontal-center\"\u003E\n\n\n    \u003Cfigure\u003E\n     \n      \u003Cimg\n        src=\"https:\u002F\u002Fupload.wikimedia.org\u002Fwikipedia\u002Fcommons\u002Fthumb\u002Fe\u002Fe7\u002FNecker_cube.svg\u002F2560px-Necker_cube.svg.png\" \n        width=\"300\" \n        \n        height=\"300\"\u003E\n        \u003Cbr\u002F\u003E\n        \u003Cfigcaption\u003E Upper panel: The Necker cube  \u003C\u002Ffigcaption\u003E\n\n \u003C\u002Ffigure\u003E\n\n  \u003C\u002Fmain\u003E\n\n   \u003Cmain class=\"content-vertical-center content-horizontal-center\"\u003E\n \n\n      \u003Cfigure\u003E\n        \u003Cimg\n        src=\"https:\u002F\u002Fupload.wikimedia.org\u002Fwikipedia\u002Fcommons\u002Fthumb\u002Fe\u002Fee\u002FCube1.svg\u002F2560px-Cube1.svg.png\" \n        width=\"200\" \n        height=\"200\"\n        title = \"Lower panel. Configuration A\"\n        align = \"left\"\u003E\n        \u003Cbr\u002F\u003E\n        \u003Cfigcaption\u003E Lower panel. Configuration A\u003C\u002Ffigcaption\u003E\n      \u003C\u002Ffigure\u003E\n\n     \u003Cfigure\u003E\n        \u003Cimg\n        src=\"https:\u002F\u002Fupload.wikimedia.org\u002Fwikipedia\u002Fcommons\u002Fthumb\u002F7\u002F7d\u002FCube2.svg\u002F2560px-Cube2.svg.png\" \n        width=\"200\" \n        height=\"200\"\n        title = \"Lower panel.  Configuration B\"\n\n        align = \"right\"\u003E      \n        \u003Cfigcaption\u003E Lower panel. Configuration B\u003C\u002Ffigcaption\u003E\n    \u003C\u002Ffigure\u003E\n\n  \u003C\u002Fmain\u003E\n\n\n\n\u003Cfooter\u003E\n  Please press \u003Ckbd\u003Espace\u003C\u002Fkbd\u003E\n  to proceed to the instructions for this study.\n\u003C\u002Ffooter\u003E"
    },
    {
      "type": "lab.html.Screen",
      "parameters": {},
      "responses": {
        "keypress(Space)": "Continue"
      },
      "messageHandlers": {},
      "title": "Ready-set-go",
      "content": "\u003Cmain class=\"content-vertical-center content-horizontal-center\"\u003E\n  \u003Cdiv class=\"w-s text-justify\"\u003E\n    \u003Ch1 class=\"text-center\"\u003EReady?\u003C\u002Fh1\u003E\n    \u003Cp\u003ELet's get going. \n      Please remember that your job is to hit the space key \n      as soon as and every time when your perception of the cube changes.\u003C\u002Fp\u003E\n    \u003Cp\u003EPlease hit \u003Ckbd\u003ESpace\u003C\u002Fkbd\u003E-Taste, if you are ready to start.\n  \u003C\u002Fdiv\u003E\n\u003C\u002Fmain\u003E\n\n\n\u003Cfooter\u003E\n  Please press \u003Ckbd\u003ESpace\u003C\u002Fkbd\u003E to begin the experiment.\n\u003C\u002Ffooter\u003E"
    },
    {
      "type": "lab.flow.Loop",
      "parameters": {},
      "templateParameters": [
        {
          "repetition": "1"
        },
        {
          "repetition": "2"
        },
        {
          "repetition": "3"
        },
        {
          "repetition": "4"
        },
        {
          "repetition": "5"
        },
        {
          "repetition": "6"
        }
      ],
      "responses": {},
      "messageHandlers": {},
      "shuffle": false,
      "title": "Necker Loop",
      "sample": {
        "n": "",
        "replace": true
      },
      "template": {
        "type": "lab.flow.Sequence",
        "parameters": {},
        "responses": {},
        "messageHandlers": {},
        "title": "Necker Trial",
        "content": [
          {
            "type": "lab.html.Screen",
            "parameters": {},
            "responses": {
              "keypress(Space)": "Flip"
            },
            "messageHandlers": {},
            "title": "Necker show",
            "content": "\n\u003Cdiv class=\"container\"\u003E\n  \u003Cmain class=\"content-vertical-center content-horizontal-center\"\u003E\n      \u003Cdiv class=\"w-s text-justify\"\u003E\n        \u003Cp\u003EFocus on the cube.\u003C\u002Fp\u003E\n        \u003Cp\u003EHit the \u003Ckbd\u003ESpace\u003C\u002Fkbd\u003E key, \n        as soon as your perception flips. \u003C\u002Fp\u003E\n      \u003C\u002Fdiv\u003E\n\n    \u003Cbr \u002F\u003E\n  \u003C\u002Fmain\u003E\n  \u003Cmain class=\"content-vertical-center content-horizontal-center\"\u003E\n\n\n    \u003Cfigure\u003E\n      \u003Cimg\n        src=\"https:\u002F\u002Fupload.wikimedia.org\u002Fwikipedia\u002Fcommons\u002Fthumb\u002Fe\u002Fe7\u002FNecker_cube.svg\u002F2560px-Necker_cube.svg.png\" \n        width=\"600\" \n        height=\"600\"\u003E\n    \u003C\u002Ffigure\u003E\n\n  \u003C\u002Fmain\u003E\n\u003C\u002Fdiv\u003E\n\n\n\n\n\u003Cfooter\u003E\n  Please press \u003Ckbd\u003Espace\u003C\u002Fkbd\u003E\n  as soon as your perceptions flips.\n\u003C\u002Ffooter\u003E",
            "tardy": true
          },
          {
            "type": "lab.html.Screen",
            "parameters": {},
            "responses": {},
            "messageHandlers": {},
            "title": "Inter-trail interval",
            "content": "\u003Cmain class=\"content-vertical-center content-horizontal-center\"\u003E\n  \u003Cdiv style=\"font-size: 3.5rem\"\u003E\n    +\n  \u003C\u002Fdiv\u003E\n\n  \n  \u003C\u002Fmain\u003E\n\n\n\n\u003Cfooter\u003E\n  Please press \u003Ckbd\u003Espace\u003C\u002Fkbd\u003E\n  as soon as your perceptions flips the next time.\n\u003C\u002Ffooter\u003E",
            "timeout": "500"
          }
        ]
      }
    },
    {
      "type": "lab.html.Screen",
      "parameters": {},
      "responses": {
        "keypress(Space)": "Continue"
      },
      "messageHandlers": {},
      "title": "Pseudonym",
      "content": "\u003Cheader\u003E\n  \u003Ch1\u003EPersonal and study ID (optional)\u003C\u002Fh1\u003E\n\u003C\u002Fheader\u003E\n\n\n\n\u003Cmain class=\"content-vertical-center content-horizontal-center\"\u003E\n\u003Cdiv class=\"w-m text-justify\"\u003E\n\n \u003Cp\u003E If you have been asked to create a personal anonymous ID (pseudonym), \n   please enter it below. \n   Similarly, if have have been given an ID for this study, \n   please enter it in the second box.\n \u003C\u002Fp\u003E\n\n \u003Cp\u003E   \n   If you do not have that information, just skip the respective box.\n \u003C\u002Fp\u003E\n\n\n\u003Cform id=\"form\"\u003E \n    \u003C!-- The form = \"form\" part links this input to the form in the main part. By inserting \"required\", people won't be able to proceed without answering. --\u003E\n    \u003Ctable class=\"table-plain\"\u003E      \n   \n  \u003Ctr\u003E\n        \u003Cth style=\"text-align: right;\"\u003E\n          \u003Clabel for=\"pseudonym\"\u003EPlease enter your anonymous ID here:\u003C\u002Flabel\u003E \n          \u003C!-- In this case we want people to fill in a text field. We can adjust the width of the textfield by using the style-element. --\u003E\n       \u003C\u002Fth\u003E\n        \u003Ctd style=\"text-align: left;\"\u003E \n        \u003Cinput id=\"pseudonym\" name=\"pseudonym\" type=\"text\" style=\"width: 20em;\" required\u003E \n        \u003C\u002Ftd\u003E  \n  \u003C\u002Ftr\u003E\n  \u003Ctr\u003E\n    \u003Cth style=\"text-align: right;\"\u003E\n          \u003Clabel for=\"studyid\"\u003EPlease enter your study ID here:\u003C\u002Flabel\u003E \n          \u003C!-- In this case we want people to fill in a text field. We can adjust the width of the textfield by using the style-element. --\u003E\n       \u003C\u002Fth\u003E\n       \u003Ctd style=\"text-align: left;\"\u003E \n        \u003Cinput id=\"studyid\" name=\"studyid\" type=\"text\" style=\"width: 20em;\" required\u003E \n        \u003C\u002Ftd\u003E  \n      \u003C\u002Ftr\u003E  \n\u003C\u002Ftable\u003E\n\n\n\n\n\u003C\u002Fmain\u003E\n\n\u003Cfooter\u003E\n  Please press \u003Ckbd\u003ESpace\u003C\u002Fkbd\u003E to continue.\n\u003C\u002Ffooter\u003E"
    },
    {
      "type": "lab.html.Screen",
      "parameters": {},
      "responses": {},
      "messageHandlers": {},
      "title": "End",
      "content": "\u003Cmain class=\"content-vertical-center content-horizontal-center\"\u003E\n\n  \u003Cdiv\u003E\n    \u003Ch2\u003EThank you for taking part!\u003C\u002Fh2\u003E\n    The study is finished. You can close this window now.\n  \u003C\u002Fdiv\u003E\n\u003C\u002Fmain\u003E\n\n\n\n\u003Cmain class=\"content-vertical-center content-horizontal-center\"\u003E\n\n  \u003Cdiv class=\"w-m text-justify\"\u003E\n     \u003Cp\u003EThis study is part of ongoing research activities \n      of the department of psychology at the FOM university.\n      The principal investigator is Professor \u003Ca href=\"mailto:sebastian.sauer@fom.de\"\u003ESebastian Sauer\u003C\u002Fa\u003E. \n      Please contact him for any questions. \n      Your participation supports the research about mental processing.\n      \u003C\u002Fp\u003E\n\n    \u003Cp\u003E\n      Principal investigator: \u003Cbr\u003E\n      Professor Sebastian Sauer \u003C\u002Fbr\u003E\n      FOM University \u003Cbr\u003E\n      email: sebastian.sauer@fom.de \u003Cbr\u003E\n      url: \u003Ca href=\"https:\u002F\u002Fwww.fom.de\u002Fforschung\u002Finstitute\u002Fiwp.html\"\u003E \n      https:\u002F\u002Fwww.fom.de\u002Fforschung\u002Finstitute\u002Fiwp.html \u003C\u002Fa\u003E\n      \u003C\u002Fp\u003E\n  \u003C\u002Fdiv\u003E\n\n\u003C\u002Fmain\u003E\n\n"
    }
  ]
})

// Add data storage support
study.options.datastore = new lab.data.Store()

// Let's go!
study.run()