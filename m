Content-Type: multipart/mixed; boundary="===============4235894412278195975=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH] rilmodem: Fix GPRS feature inavailable issue
Date: Thu, 14 Jan 2016 09:52:35 -0600
Message-ID: <5697C443.7090609@gmail.com>
In-Reply-To: <DA62CA5DDF4CA640AA25B1684E5D141102069F97@shsmsx102.ccr.corp.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4235894412278195975==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Caiwen,

Please don't top-post on this list.  Thanks for your understanding.

Now as to your question:

 >
> In fact I have ever considered the way you mentioned. But l found in most=
 plugins, atoms (gprs, gprs_context, sms,
> call_forwarding ...) are created at post_sim phrase. It seems post_online=
 phrase is more reasonable. There should
> be some reason that the atom creation is brought forward. Does anyone kno=
w the reason?
>

It really depends on what the particular atom supports and what the =

hardware supports.  The modem driver has some leeway to place atoms in =

the appropriate state callback (.pre_sim, .post_sim, .post_online).

Generally, anything that accesses the SIM can safely go into .post_sim =

if the hardware supports this mode properly, e.g. sim on, rx/tx radio =

circuits off.  sim and gprs atoms also support being in post_sim.  This =

is done so that settings can be tweaked while offline.

In the case of the rilmodem gprs driver, the querying of max_cids is =

needed in order to tell oFono core the id range.  This operation needs =

to be done once before the atom is registered.  If this operation is not =

available on the RIL in 'post_sim' (not online) state, then it is  safer =

to move the gprs atom into post_online callback than trying to follow =

radio state changes and (repeatedly) query max_cids.

If you really need gprs to be in post_sim, then we can discuss some =

alternative solutions.

Regards,
-Denis

--===============4235894412278195975==--

