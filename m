Content-Type: multipart/mixed; boundary="===============8077757833665204739=="
MIME-Version: 1.0
From: Alexander Kanavin <alexander.kanavin@nokia.com>
Subject: Re: return values of org.ofono.SupplementaryServices.Initiate
Date: Thu, 07 Oct 2010 12:49:52 +0300
Message-ID: <4CAD97C0.4050203@nokia.com>
In-Reply-To: <4CAD1644.40302@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8077757833665204739==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On 07.10.2010 3:37, ext Denis Kenzior wrote:
> This is on my TODO list, but honestly it would take you no more than 2
> hours to do this yourself for most of the reply types.  All the reply
> generators are nicely compartmentalized (call-barring.c:
> generate_ss_query_reply, call-forwarding.c: cf_ss_control_reply,
> call-settings.c: generate_cw_ss_query_reply, clip_colp_colr_ss_query_cb)
>
> And you don't really need to handle all the combinations, simply stating
> that the elements returned in the dictionary were affected by the SS
> operation is enough.

Yeah, I'm actually halfway through that now. I also found a couple of typos =

in the code. Patches will come soon.

> This patch set predates the launch of oFono as 'oFono'.  So far nobody
> has been attempting to use this API ;)

Except me I guess - I'm now working on a Qt bindings library for oFono.

Alex

--===============8077757833665204739==--

