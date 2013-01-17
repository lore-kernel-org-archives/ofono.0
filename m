Content-Type: multipart/mixed; boundary="===============2406211648346849858=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH v0 3/8] hfpmodem: Add support for sending the supported
 codecs
Date: Thu, 17 Jan 2013 11:22:43 -0600
Message-ID: <50F83363.8020701@gmail.com>
In-Reply-To: <1358435591-14757-4-git-send-email-claudio.takahasi@openbossa.org>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2406211648346849858==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Claudio,

On 01/17/2013 09:13 AM, Claudio Takahasi wrote:
> From: Vinicius Costa Gomes<vinicius.gomes@openbossa.org>
>
> Right now, only the mandatory CVSD codec is supported. The mSBC
> mandatory codec is "temporarily" not supported.
>
> The spec alows this, HFP 1.6 Spec Section 4.34.1 page 92: "If wide band
> speech is supported then the mandatory codec (mSBC) shall be included
> unless it is temporarily unavailable."
> ---
>   drivers/hfpmodem/slc.c | 29 +++++++++++++++++++++++++++++
>   1 file changed, 29 insertions(+)

Patch has been applied, thanks.

Regards,
-Denis


--===============2406211648346849858==--

