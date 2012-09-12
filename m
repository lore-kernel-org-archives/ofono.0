Content-Type: multipart/mixed; boundary="===============6978333191083510256=="
MIME-Version: 1.0
From: Christopher Vogl <christopher.vogl@hale.at>
Subject: Re: [PATCH 2/2] netreg: Add telit version for ciev notification
Date: Wed, 12 Sep 2012 17:07:51 +0200
Message-ID: <5050A547.7080109@hale.at>
In-Reply-To: <505093BE.2080203@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6978333191083510256==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Denis,

> Strange, ofono shouldn't even let you attach or activate the context =

> until after the netreg atom is fully initialized.  Do you have a log?

I don't know how this could have happened, but before I tried it two =

times and I surely saw the ppp-setup after netreg was removed (should =

have saved the log).
Now I cannot reproduce it and it works as it should - netreg gets remove =

and no GPRS attachment.

Regards,
Christopher



--
Scanned by MailScanner.


--===============6978333191083510256==--

