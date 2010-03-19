Content-Type: multipart/mixed; boundary="===============1820147372611093456=="
MIME-Version: 1.0
From: Dario <djdas@djdas.net>
Subject: [Usage] SMS handling
Date: Fri, 19 Mar 2010 14:59:01 +0100
Message-ID: <4BA38325.80204@djdas.net>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1820147372611093456==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi all,
I have a question: what is the best practice (or the suggested =

behaviour) to handle SMSes in an application using oFono?
I am thinking about two common cases:
1) handling outgoing message status: I use the SendMessage DBus API but =

AFAIK I'm not aware of the status of the sending operation (pending, =

blocked, sent...) in the DBus response;
2) handling incoming messages when application is (re)starting/crashed: =

is there a way to retrieve a message if it comes in during a phase where =

the application is not running or it can't receive the IncomingMessage =

signal? Does oFono logs or stores the messages somewhere?

I think I found something in the "Example Call History" plugin, does =

this mean I need to create an oFono plugin to manage my application =

needs or am I missing some info/API somewhere?

Thank you in advance, best regards,
Dario.



--===============1820147372611093456==--

