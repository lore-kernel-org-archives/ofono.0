Content-Type: multipart/mixed; boundary="===============2705817317530929958=="
MIME-Version: 1.0
From: Jens Rehsack <jr_extern@vfnet.de>
Subject: Enhancing mmsd
Date: Fri, 24 Feb 2012 14:29:57 +0100
Message-ID: <4F4790D5.3040608@vfnet.de>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2705817317530929958==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi,

as announced in my last mail, I'm here to work with + improve ofono
and related software.

My next task will be to implement an ofono plugin which handles some
UPL push messages. Because there is only one "listener" at
org.ofono.PushNotificationAgent possible, I see two and a half way
to go on:

1) fork ofono-mmsd to handle more message types than mms
   (via plugins?)
   1b) fork ofono-mmsd to handle only SUPL push messages
2) find a way for more listeners on push messages

Any suggestions, preferred ways?

Best regards and have a nice weekend,
Jens

--===============2705817317530929958==--

