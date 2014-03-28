Content-Type: multipart/mixed; boundary="===============7891384131658896490=="
MIME-Version: 1.0
From: Eric BOUXIROT <eric.bouxirot@azimut-monitoring.com>
Subject: Re: wwan0 interface without IP
Date: Fri, 28 Mar 2014 16:35:49 +0100
Message-ID: <lh44s7$s5$1@ger.gmane.org>
In-Reply-To: <53358B76.9000505@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7891384131658896490==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

> oFono does not assign the IP parameters.  ConnMan does that or you need
> to do this some other way.

i'm right with you but i don't know how ofono deal with connman to trig =

DHCP.
i know ofono send some parameters (or connman read it on ofono..) like =

"method" "address" etc..
i know when reading "address" the result is NULL and fail next step in =

connman du to NULL.

i have made a test patch that put "0.0.0.0" in address in =

swmodem/gprs_context.c after connect success, but it seem connman =

always read NULL..


then, i search more what's happend.
I found a solution with connman's ofono plugin that need to be patched.

Now that work great, but i mean there something wrong between =

ofono/connman altought for this modem.


--===============7891384131658896490==--

