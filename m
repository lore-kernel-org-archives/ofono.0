Content-Type: multipart/mixed; boundary="===============2124394605958911376=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH] hfp_hf_bluez5: Fix not considering that UUIDs change
 after creation
Date: Thu, 18 Apr 2013 08:39:30 -0500
Message-ID: <516FF792.1080805@gmail.com>
In-Reply-To: <1366307438-19867-1-git-send-email-vinicius.gomes@openbossa.org>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2124394605958911376==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Vinicius,

On 04/18/2013 12:50 PM, Vinicius Costa Gomes wrote:
> For example, in the case of a incoming connection the device may be
> created without UUIDs and the property changed is emitted later.
> ---
>   plugins/hfp_hf_bluez5.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
>

Patch has been applied, thanks.

Regards,
-Denis


--===============2124394605958911376==--

