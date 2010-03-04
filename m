Content-Type: multipart/mixed; boundary="===============6676526177026329091=="
MIME-Version: 1.0
From: Zhenhua Zhang <zhenhua.zhang@intel.com>
Subject: Re: [PATCH 2/4] Fix remove wrong extended prefix
Date: Thu, 04 Mar 2010 09:38:19 +0800
Message-ID: <4B8F0F0B.9050806@intel.com>
In-Reply-To: <201003031317.40139.denkenz@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6676526177026329091==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Denis,

On 03/04/2010 03:17 AM, Denis Kenzior wrote:
> Hi Zhenhua,
>
>> ATA, ATH and ATD are belongs to basic command. So removed them.
>
> All of these need to be handled by user callbacks, so effectively they ne=
ed to
> be treated like extended commands.  Especially with the weird ATD syntax =
rules
> that 27.007 introduces.

The basic and extended command are treated as the same internally. So =

user could also register basic command callbacks. ATD and ATA are =

handled in "[PATCH 3/7] Add basic command parsing".

> Regards,
> -Denis
> _______________________________________________
> ofono mailing list
> ofono(a)ofono.org
> http://lists.ofono.org/listinfo/ofono
>


--===============6676526177026329091==--

