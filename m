Content-Type: multipart/mixed; boundary="===============4243548596862876156=="
MIME-Version: 1.0
From: Oleg Zhurakivskyy <oleg.zhurakivskyy@intel.com>
Subject: Re: [PATCHv8 3/6] plugins: mobile-broadband-provider-info parser
 changes
Date: Tue, 04 Oct 2011 12:33:41 +0300
Message-ID: <4E8AD2F5.50308@intel.com>
In-Reply-To: <4E85D8E9.4010302@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4243548596862876156==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hello Denis,

On 09/30/2011 05:57 PM, Denis Kenzior wrote:
> This patch makes no logical sense.  If you want to add a new
> mbpi_ap_type function, then send a patch against mbpi.h and mbpi.c
> adding such a function.
>
> If you want to rename mbpi_provision_data_free to mbpi_ap_free, then
> send a patch against mbpi.h, mbpi.c and a separate patch against
> tools/lookup-apn.c
>
> The only time you should separate .h and .c patches are when you're
> modifying public API in include/*
>
> See HACKING document, the 'Submitting patches' section in particular.

Thanks for the info, indeed splitting of patches per directory is explained =

there. However, 'Submitting patches' is actually silent about the rest.

I will prepare and send another patch set.

Regards,
Oleg
-- =

Intel Finland Oy
Registered Address: PL 281, 00181 Helsinki
Business Identity Code: 0357606 - 4
Domiciled in Helsinki


--===============4243548596862876156==--

