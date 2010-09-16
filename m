Content-Type: multipart/mixed; boundary="===============1728896350596185415=="
MIME-Version: 1.0
From: =?unknown-8bit?q?R=C3=A9mi?= Denis-Courmont <remi@remlab.net>
Subject: Re: [n900 PATCH 2/5] isigen: generic modem driver plugin for isimodems
Date: Fri, 17 Sep 2010 01:45:59 +0200
Message-ID: <53bb2abc324cd8002bbeaab6db1164e1@chewa.net>
In-Reply-To: <1284618394.2405.94.camel@localhost.localdomain>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1728896350596185415==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable


On Thu, 16 Sep 2010 15:26:34 +0900, Marcel Holtmann <marcel@holtmann.org>
wrote:
>> >> That is the goal if and when we have up-to-date kernel, but
>> >> we are not there yet.
>> >
>> > I don't see the point of adding temporary cruft to the main oFono
>> > repository then.
>>
>> Well, I see value in having oFono upstream work as-is with the current
>> MeeGo kernel. The plugin could of course reside somewhere else, but
>> that is just adding extra work for packagers. And it's not like we
>> can't fix the plugin once MeeGo has a proper kernel in place.
> =

> what is the current state of Phonet support (including N900) and the
> current MeeGo kernel? Are we missing patches?

I did not fully grasp what the extra Netlink code does. There should be no
need to CONFIGURE the Phonet stack via Netlink. If there is, then it's a
kernel bug.

-- =

R=C3=A9mi Denis-Courmont
http://www.remlab.net
http://fi.linkedin.com/in/remidenis


--===============1728896350596185415==--

