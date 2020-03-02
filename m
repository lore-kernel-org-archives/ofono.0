Content-Type: multipart/mixed; boundary="===============3437477400995860568=="
MIME-Version: 1.0
From: Martin =?unknown-8bit?q?Hundeb=C3=B8ll?= <martin@geanix.com>
Subject: Re: Expose MBPI api over d-bus
Date: Mon, 02 Mar 2020 14:56:50 +0100
Message-ID: <bfbeb7a8-3b94-edd7-7f1f-a33f9f4b3679@geanix.com>
In-Reply-To: <CABPh3UMhmK4vgDGitCROYk2hV-RCjENd6AV_Pfaobq6rS2sr+A@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3437477400995860568==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi,

On 02/03/2020 14.49, nick83ola wrote:
> Hi all,
> In regarding to this I found the provision plugin and at line 53 it
> uses the mbpi lookup to provision for the default apns but at line 53
> it does
> =

> apns =3D mbpi_lookup_apn(mcc, mnc, FALSE, &error);
> =

> that gives an error in case of multiple providers. -> but if I change
> it to gboolean allow_duplicates=3DTRUE
> It works and it creates multiple contexts
> =

> ap_count =3D g_slist_length(apns);
> .....
> for (l =3D apns, i =3D 0; l; l =3D l->next, i++) {
> struct ofono_gprs_provision_data *ap =3D l->data;
> =

> memcpy(*settings + i, ap,
> sizeof(struct ofono_gprs_provision_data));
> =

> g_free(ap);
> }
> =

> What's the issue in setting mbpi_lookup_apn(mcc, mnc, TRUE, &error); ?????

You're not the first:
https://lists.ofono.org/hyperkitty/list/ofono(a)ofono.org/thread/2SC46PH5CW=
T3A3HTHGUKUUVI3QDYIL73/#7B6CPARJQMZUBQUPXBJMAOXZY4RW2L3D

:)

// Martin
--===============3437477400995860568==--

