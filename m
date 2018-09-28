Content-Type: multipart/mixed; boundary="===============3145754652459140209=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: status
Date: Fri, 28 Sep 2018 09:04:25 -0500
Message-ID: <2a96466c-ea65-56a0-461e-888d54076dc0@gmail.com>
In-Reply-To: <8fa934fd-8da7-5953-4543-3b7487e97aec@monom.org>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3145754652459140209==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Daniel,

> While we have DHCP code in ConnMan I wouldn't recommend to port it as it
> is. Patrik reimplemented DHCP for systemd-netword using ConnMan's
> version as blueprint. That code looks much saner. Propably, it would
> make sense to carve out a library (using ELL as support library) from
> the systemd's version and make ConnMan and oFono depending on it.

Yep, I think ell is the logical place for it.  I have started putting =

together the basics for DHCP based on ideas in ConnMan/systemd and =

trying a few new ideas as well.  The approach in systemd was a bit =

heavy-handed for my taste with the use of BPFs flying everywhere.  I =

still need to see whether a simpler approach would be workable, but have =

been busy elsewhere.

Regards,
-Denis

--===============3145754652459140209==--

