Content-Type: multipart/mixed; boundary="===============2414269378901688592=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: GPS
Date: Tue, 19 Apr 2011 09:12:46 -0500
Message-ID: <4DAD985E.8050903@gmail.com>
In-Reply-To: <BANLkTikJsZa-2k7pJrALN3GW2ir3oH_hUw@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2414269378901688592==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Mamata,

>     I need some info regarding the GPS support in ofono. I see that
>     there is some NMEA related information which can be retrieved using
>     GPS Api's, Does this also address AGPS functionality? If not please
>     let me is there any plan to support  the same.

Please see doc/assisted-satellite-navigation-api.txt.  That is the
current API proposal with implementation in src/gnss.c.  The
implementation is highly experimental and does not currently have a
specific modem driver implementation.

The task associated with the above is 'Add Location Service API' in the
TODO list.  It currently has no owner.

Regards,
-Denis

--===============2414269378901688592==--

