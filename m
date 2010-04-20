Content-Type: multipart/mixed; boundary="===============1946135870458792412=="
MIME-Version: 1.0
From: Zhenhua Zhang <zhenhua.zhang@intel.com>
Subject: Re: [PATCH] Add send_method_call to g_dbus
Date: Tue, 20 Apr 2010 17:41:08 +0800
Message-ID: <4BCD76B4.7040101@intel.com>
In-Reply-To: <87y6giqxjz.fsf@potku.valot.fi>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1946135870458792412==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Valo,

On 04/20/2010 05:32 PM, Kalle Valo wrote:
> "Gustavo F. Padovan"<gustavo@padovan.org>  writes:
>
>> Puting send_method_call and send_method_call_with_reply on g_dbus will
>> avoid some code duplication and will make things easier mainly for the
>> Bluetooth plugins (HFP, DUN, SAP) inside oFono.
>
> Sorry, totally unrelated to this patch, but is there a BT DUN plugin for
> ofono available somewhere? I would love to test it.
>

Not yet. We are working on BT DUN plugin right now. And it requires some =

intergration efforts with Connman, PPP stack, etc.

Thanks.
Zhenhua

--===============1946135870458792412==--

