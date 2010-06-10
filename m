Content-Type: multipart/mixed; boundary="===============7125217750113095729=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: SMS status report
Date: Thu, 10 Jun 2010 09:47:28 -0500
Message-ID: <201006100947.29139.denkenz@gmail.com>
In-Reply-To: <1276153545-22260-1-git-send-email-pasi.miettinen@ixonos.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7125217750113095729==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Pasi,

> So if one mr is concidered undeliverable, the whole id is removed
> from the data structure and the mr numbers that still may arrive
> as "delivered" are not taken into account anymore.

That sounds fine.

> =

> Do we already have a plan for how accurately we are going to check
> these status report status codes?

My thinking right now is that we should take all success and all permanent =

error codes into account.  But that is quite easy...

Was there something else to your question?

Regards,
-Denis

--===============7125217750113095729==--

