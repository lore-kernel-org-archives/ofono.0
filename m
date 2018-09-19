Content-Type: multipart/mixed; boundary="===============1310640507519635080=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 1/7] extended support for LTE and NR. Some minor fixes.
 part 1 of 7
Date: Wed, 19 Sep 2018 11:32:35 -0500
Message-ID: <9b74d1aa-9d2d-aaee-b510-003f79c6ff73@gmail.com>
In-Reply-To: <8ce15cf4-9505-c68c-8080-fc1ce97df3b8@jolla.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1310640507519635080==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Slava,

> Anything in include is external API. We do maintain not just =

> out-of-tree, but binary plugins. Backward (binary!) compatibility a must =

> for us. Please do not break it.

That is why we have 'OFONO_API_SUBJECT_TO_CHANGE' as a reminder.  We =

mean it.  D-Bus API is stable, we never made any guarantees about the =

internal APIs.

Regards,
-Denis

--===============1310640507519635080==--

