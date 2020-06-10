Content-Type: multipart/mixed; boundary="===============6472312209924450109=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH v2] [qmimodem] Implement data capability bearer notify
Date: Wed, 10 Jun 2020 14:24:46 -0500
Message-ID: <aa33a21f-c6e4-ac58-4092-da94b1ffcd2a@gmail.com>
In-Reply-To: <20200610134418.745509-1-marius@ubports.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6472312209924450109==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Marius,

On 6/10/20 8:44 AM, Marius Gripsgard wrote:
> This implements data capability bearer notify to qmi modem.
> Since this is included in the serving system response this
> just adds a new data extraction for dc.
> ---
>   drivers/qmimodem/gprs.c | 27 +++++++++++++++++++++++++++
>   drivers/qmimodem/nas.c  | 36 ++++++++++++++++++++++++++++++++++++
>   drivers/qmimodem/nas.h  | 23 +++++++++++++++++++++++
>   3 files changed, 86 insertions(+)
> =


<snip>

> +	// DC is optional so only notify on successful extraction
> +	if (extract_dc_info(result, &bearer_tech))
> +		ofono_gprs_bearer_notify(gprs, bearer_tech);
> +

I changed the above C++ comment into C style and applied.  Thanks!

Regards
-Denis

--===============6472312209924450109==--

