Content-Type: multipart/mixed; boundary="===============0347582408646755647=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH] Add vendor quirk for SIMCOM
Date: Tue, 12 Mar 2013 13:02:42 -0500
Message-ID: <513F6DC2.8070803@gmail.com>
In-Reply-To: <513F4758.3060801@syscom-instruments.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0347582408646755647==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Anthony,

> And, I saw "ATD*99#" cryptic command was already used in
> gatchat/gsmdial.c if bluetooth is enabled.
>

This is a legacy operation for entering into data mode.  Refer to 27.007 =

Section 10.2.1.1.  It can be used as a shortcut for CGDCONT/CGDATA, and =

it seems that some modems do not implement CGDATA at all.

> Otherwise, why this \0 after ATD*99# ? :)
>

Good spot ;)

Regards,
-Denis


--===============0347582408646755647==--

