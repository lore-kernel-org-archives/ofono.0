Content-Type: multipart/mixed; boundary="===============4063205515801710686=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: CDMA voicecall driver
Date: Fri, 21 Jun 2013 12:04:04 -0500
Message-ID: <51C48784.5040907@gmail.com>
In-Reply-To: <BAY164-W70E71C721A282EC7D6CA4A58F0@phx.gbl>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4063205515801710686==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi,

 > They do have a lot of differences but not in dbus method layer. For
> example,
> ofono_voicecall_driver has methods like dial, answer, hangup all,
> hold_all_active...etc,
> I believe cdma will have almost same methods like GSM. When we are using
> them in
> application layer, we will call the same method name but different kind
> of modem driver.
> I am wondering why ofono created two different interface name and provide
> the same call method?

The basics are the same, sure.  However, once you get into the details =

of three way calls, call waiting, multiparty calls, etc the logic and =

API becomes vastly different.

Not to mention the various differences between carriers and their =

specific extensions.

Bottom line is, compared to insanity of GSM/UMTS, CDMA is even more of a =

mess and the API needs to evolve on its own.  In the future, if it makes =

sense to unify them, then we can do so.  That time is not now.

Regards,
-Denis


--===============4063205515801710686==--

