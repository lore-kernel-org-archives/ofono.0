Content-Type: multipart/mixed; boundary="===============8456526643157988908=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [RFC PATCH 1/8] simfs: add logic to retrieve only only EF-info,
 but no EF-contents
Date: Fri, 15 Oct 2010 07:19:53 -0500
Message-ID: <4CB846E9.2070507@gmail.com>
In-Reply-To: <1287090175-3018-2-git-send-email-petteri.tikander@ixonos.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8456526643157988908==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Petteri,

On 10/14/2010 04:02 PM, Petteri Tikander wrote:
> Handling of new parameter (file status) from the driver added.
> This commit doesn't store EF-info into cache yet.

Please keep your commit header to less than 50 characters.

> +	if (op->info_only) {
> +		/*
> +		 * It's info-only request. So there is no need to request
> +		 * actual contents of the EF-files. Just return the EF-info.
> +		 */
> +		cb(1, op->length, op->current,
> +			&file_status, op->record_length, op->userdata);
> +

So I honestly don't like us using the ofono_sim_file_read_cb_t for the
callback in the info only case.  Can we invent a new callback type
specifically for this case?

Regards,
-Denis

--===============8456526643157988908==--

