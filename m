Content-Type: multipart/mixed; boundary="===============2959705198304632995=="
MIME-Version: 1.0
From: nalso@naver.com
Subject: Re: Question about static analysis
Date: Thu, 12 Aug 2021 01:33:51 +0000
Message-ID: <20210812013351.2797.60752@ml01.vlan13.01.org>
In-Reply-To: <62ca3f8c-672c-c3a3-d5b4-2f7256e3899c@jolla.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2959705198304632995==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Slava

Thanks for the clear explanation.
I respect your opinion use g_slist_delete_link()  instead of g_slist_remove=
().

And other way, g_slist_remove () look like free data of element. so not nee=
d g_free() before use g_slist_remove().

Thankyou.
song
--===============2959705198304632995==--

