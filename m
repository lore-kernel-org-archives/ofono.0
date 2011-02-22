Content-Type: multipart/mixed; boundary="===============0574533665965863937=="
MIME-Version: 1.0
From: Antoine Reversat <a.reversat@gmail.com>
Subject: Re: [PATCH] Add CNAP support (callerid name presentation) to isimodem
Date: Tue, 22 Feb 2011 16:34:25 -0500
Message-ID: <AANLkTinf5qt5r+CWOEX-2Wk5XoZhtmfPhufTOgHz36Qx@mail.gmail.com>
In-Reply-To: <20110222212224.GD2249@joana>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0574533665965863937==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 22, 2011 at 4:22 PM, Gustavo F. Padovan
<padovan@profusion.mobi> wrote:
> Hi Antoine,

Hi

>> + =C2=A0 =C2=A0 if (!g_isi_sb_iter_get_byte(sb, &pres, 2) ||
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
!g_isi_sb_iter_get_byte(sb, &id, 6) ||
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
!g_isi_sb_iter_get_byte(sb, &len, 7) ||
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
!g_isi_sb_iter_get_alpha_tag(sb, &name, 2 * len, 8))
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return;
>
>
> Isn't this better:
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0if (!g_isi_sb_iter_get_byte())
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0if (!g_isi_sb_iter_get_byte())
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0if (!g_isi_sb_iter_get_byte())
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0if (!g_isi_sb_iter_get_alpha_tag())
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return;

It is better, my code is based on isi_call_any_address_sb_proc which
has the same construct. I guess I'll fix both then.

>

I'll fix the rest and resend the patch, thanks.

--===============0574533665965863937==--

