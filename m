Content-Type: multipart/mixed; boundary="===============5823542710035328942=="
MIME-Version: 1.0
From: Andrzej Zaborowski <andrew.zaborowski@intel.com>
Subject: Re: Unint var with GCC 4.5.2
Date: Fri, 06 May 2011 20:59:44 +0200
Message-ID: <BANLkTik8oN-02pgupcYKPG5bpsbHDfDa7w@mail.gmail.com>
In-Reply-To: <A782C372B9527D44AB20BF45FEEBB14F75C5086A2D@irsmsx503.ger.corp.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5823542710035328942==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Bertrand,

On 6 May 2011 11:41, Aygon, Bertrand <bertrand.aygon@intel.com> wrote:
> Hi,
>
> I have switched my dev environment to Ubuntu 11.04, and so I am using GCC
> 4.5.2.
>
> Building oFono returns 2 erros due to uninit var. One is a false negative,
> so I have fix it with the =E2=80=98magic define=E2=80=99, and will send t=
he patch soon (VPN
> is dead so I cannot send it).
>
> But for the second one, I am not sure it=E2=80=99s a false negative, so I=
 would like
> to have the thought of the mailing list, and even better the author or gu=
ys
> who has some knowledge on this part of the code.

That one is a bug.  I remember it caught my eye at some point but
later I forgot about it.  This is more or less how I'd try to fix it:

--- a/src/sim.c
+++ b/src/sim.c
@@ -947,10 +947,8 @@ static void sim_get_image(struct ofono_sim *sim,
unsigned char id,

        image =3D sim_fs_get_cached_image(sim->simfs, id);

-       if (image !=3D NULL) {
+       if (image !=3D NULL)
                sim_get_image_cb(sim, id, image, FALSE);
-               goto watch;
-       }

        if (sim->efimg_length <=3D (id * 9)) {
                sim_get_image_cb(sim, id, NULL, FALSE);
@@ -963,13 +961,10 @@ static void sim_get_image(struct ofono_sim *sim,
unsigned char id,
        iidf_offset =3D efimg[5] << 8 | efimg[6];
        iidf_len =3D efimg[7] << 8 | efimg[8];

-       /* read the image data */
-       ofono_sim_read_bytes(sim->context, iidf_id, iidf_offset, iidf_len,
-                               sim_iidf_read_cb, sim);
-
-watch:
-       if (sim->efimg_length <=3D id * 9)
-               return;
+       if (image =3D=3D NULL)
+               /* read the image data */
+               ofono_sim_read_bytes(sim->context, iidf_id, iidf_offset,
+                                       iidf_len, sim_iidf_read_cb, sim);

        if (sim->iidf_watch_ids[id] > 0)
                return;

Best regards

--===============5823542710035328942==--

