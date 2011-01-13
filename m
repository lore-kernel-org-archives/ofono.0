Content-Type: multipart/mixed; boundary="===============6863151736328732566=="
MIME-Version: 1.0
From: =?unknown-8bit?q?R=C3=A9mi?= Denis-Courmont <remi.denis-courmont@nokia.com>
Subject: Re: [PATCH 00/21] Resubmit Zhenhua Zhang work on DUN server with btio
Date: Thu, 13 Jan 2011 11:18:44 +0200
Message-ID: <201101131118.44693.remi.denis-courmont@nokia.com>
In-Reply-To: <1294852564-1258-1-git-send-email-frederic.dalleau@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6863151736328732566==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Wednesday 12 January 2011 19:15:43 ext Fr=C3=A9d=C3=A9ric Dalleau, you w=
rote:
> This is rebased as of head of today

This seems quite useless work to me.

There are a number of AT commands that are required but really do not belon=
g =

in oFono. Consider for example AT+CKPD/AT+CTSA/AT+CMEC input emulation and =

AT+CBC* battery notifications. Those things have nothing to do with Cellula=
r =

other than the C in the command prefix.  Then we have commands that are rel=
ated =

to cellular functionality but higher-level than oFono, like AT+CPB* for =

phonebook.

Now, I recognize this patch only attempts to provide BT DUN profile, not th=
e =

whole 27.007 set. But doing that in userspace in oFono is probably the slow=
est =

and most inefficient approach to the problem. And MeeGo will have to solve =
the =

more general problem in any case, if MeeGo cellular devices are to be =

certified.

-- =

R=C3=A9mi Denis-Courmont
Nokia Devices R&D, Maemo Software, Helsinki

--===============6863151736328732566==--

