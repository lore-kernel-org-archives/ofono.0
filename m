Content-Type: multipart/mixed; boundary="===============0891237735357256249=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 2/4] Handle the conversion failure when parsing item
Date: Tue, 16 Mar 2010 14:29:49 -0600
Message-ID: <201003161529.49624.denkenz@gmail.com>
In-Reply-To: <1268733700-30154-2-git-send-email-yang.gu@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0891237735357256249==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Yang,

> -	item->text =3D sim_string_to_utf8(data+1, len-1);
> +	utf8 =3D sim_string_to_utf8(data+1, len-1);

I applied the patch and fixed up the arithmetic operator style issue.  Plea=
se =

make sure you follow this convention from now on.

Regards,
-Denis

--===============0891237735357256249==--

