Content-Type: multipart/mixed; boundary="===============6983518051923837798=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [RERESEND] [PATCH 2/2] Update the network documentation
Date: Tue, 23 Nov 2010 09:02:25 -0600
Message-ID: <4CEBD781.8080000@gmail.com>
In-Reply-To: <201011231658.18154.remi.denis-courmont@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6983518051923837798==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Remi,

> In fact, I have some cases where we'd need know whether HSDPA/HSUPA chann=
els =

> are actually allocated, not just whether the cell supports them. ISI does =

> that, but there does not seem to be any standard way to get that informat=
ions =

> out of the modem. In particular, I assume that both the CREG and CGREG =

> technology indications are always equal :-(

Actually they're not.  Most AT modems report HSPA/HSDPA/HSUPA only on
the CGREG command.  CREG only reports umts/edge/gsm.

In fact we were planning to report the current bearer on the
ConnectionManager interface once we figured out the vendor commands that
can actually report this information.

Regards,
-Denis

--===============6983518051923837798==--

