Content-Type: multipart/mixed; boundary="===============2035758184075966288=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH] gprs: data bearer for telit with PSNT
Date: Thu, 16 Aug 2012 01:12:21 -0500
Message-ID: <502C8F45.90502@gmail.com>
In-Reply-To: <1345104676-12706-1-git-send-email-christopher.vogl@hale.at>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2035758184075966288==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Christopher / August,

On 08/16/2012 03:11 AM, Christopher Vogl wrote:
> From: August Mayer<august.mayer@hale.at>
>
> Telit neither supports '+CPSB' nor reports the data bearer through
> '+CGREG'. It has its own +PSNT command.
> ---
>   drivers/atmodem/gprs.c |   40 ++++++++++++++++++++++++++++++++++++++++
>   1 files changed, 40 insertions(+), 0 deletions(-)
>

Patch has been applied, however I had to manually fix two trailing =

whitespace violations:

Applying: gprs: data bearer for telit with PSNT
/home/denkenz/ofono-master/.git/rebase-apply/patch:44: trailing whitespace.
	=

/home/denkenz/ofono-master/.git/rebase-apply/patch:46: trailing whitespace.
}
fatal: 2 lines add whitespace errors.

Regards,
-Denis

--===============2035758184075966288==--

