Content-Type: multipart/mixed; boundary="===============4398856684648770299=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 0/10] Unregister AT notifiers when removing drivers
Date: Wed, 11 Aug 2010 18:25:09 -0500
Message-ID: <4C633155.8070200@gmail.com>
In-Reply-To: <1281451429-17257-1-git-send-email-zhenhua.zhang@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4398856684648770299==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Zhenhua,

On 08/10/2010 09:43 AM, Zhenhua Zhang wrote:
> Hi,
> =

> This series unregister AT notifiers in removing various AT modem drivers =
when modem goes to offline mode. Please review them.
> =

> We should fix other modem drivers other than atmodem as well. I will send=
 seperate patches for review.
> =

> To Emmanuel, could you try these patches to see wheter it fixes your prob=
lems? Thanks.
> =

> Regards,
> Zhenhua
> =


Your patches are fine, however there is an alternative we'd like to
explore first that might turn out to be better.  It does require some
surgery to GAtChat...

Regards,
-Denis

--===============4398856684648770299==--

