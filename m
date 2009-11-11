Content-Type: multipart/mixed; boundary="===============3370587122944204155=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 2/2] Add call volume support for hfpmodem
Date: Wed, 11 Nov 2009 00:41:35 -0600
Message-ID: <200911110041.35538.denkenz@gmail.com>
In-Reply-To: <0463F45F3606F4428ED35AC8C709F92E089CA6A25D@pdsmsx502.ccr.corp.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3370587122944204155==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Zhenhua,
> > Make sure to ofono_call_volume_set_data(cv, NULL) here.
>
> I don't see ofono_call_volume_set_data(cv, NULL) or
> ofono_voicecall_set_data(vc, NULL) from atmodem either. Anyway, I add the
> code in hfp_call_volume_remove.
>

Then that needs to be fixed.  Care to send a patch?

In general you should set_data to NULL before freeing it.

Regards,
-Denis


--===============3370587122944204155==--

