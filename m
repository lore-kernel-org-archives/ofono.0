Content-Type: multipart/mixed; boundary="===============8717139683298394004=="
MIME-Version: 1.0
From: Giacinto Cifelli <gciofono@gmail.com>
Subject: Re: [PATCH v4 1/2] Gemalto: voicecall atom
Date: Wed, 17 Oct 2018 09:30:32 +0200
Message-ID: <CAKSBH7HTtr_bh4AcnsOCXUecLRAOvG4YHkwRaqzmp_QArEm_Mg@mail.gmail.com>
In-Reply-To: <cae21e96-7824-6e1c-7bb8-0d73b5139528@southpole.se>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8717139683298394004==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Oct 17, 2018 at 8:28 AM Jonas Bonn <jonas@southpole.se> wrote:
>
> Hi,
>
>
> On 17/10/18 06:52, Giacinto Cifelli wrote:
> > Added voicecall atom specific for Gemalto modems.
> > This atom uses the URC ^SLCC to monitor the call status, as well as
> > incoming calls.
> > Note the use in the atom of the variable GemaltoVtsQuotes: this is
> > needed to support future modules, as of today not yet available in the
> > plugin.
> > ---
> >   Makefile.am                         |   3 +-
> >   drivers/gemaltomodem/gemaltomodem.c |   3 +
> >   drivers/gemaltomodem/gemaltomodem.h |   6 +
> >   drivers/gemaltomodem/voicecall.c    | 581 ++++++++++++++++++++++++++++
> >   4 files changed, 592 insertions(+), 1 deletion(-)
> >   create mode 100644 drivers/gemaltomodem/voicecall.c
> >
> > diff --git a/Makefile.am b/Makefile.am
> > index 6667524f..e8e4ed95 100644
> > --- a/Makefile.am
> > +++ b/Makefile.am
> > @@ -397,7 +397,8 @@ builtin_modules +=3D gemaltomodem
> >   builtin_sources +=3D drivers/atmodem/atutil.h \
> >                       drivers/gemaltomodem/gemaltomodem.h \
> >                       drivers/gemaltomodem/gemaltomodem.c \
> > -                     drivers/gemaltomodem/location-reporting.c
> > +                     drivers/gemaltomodem/location-reporting.c \
> > +                     drivers/gemaltomodem/voicecall.c
> >
> >   builtin_modules +=3D xmm7modem
> >   builtin_sources +=3D drivers/atmodem/atutil.h \
> > diff --git a/drivers/gemaltomodem/gemaltomodem.c b/drivers/gemaltomodem=
/gemaltomodem.c
> > index 91cf238a..4818ac66 100644
> > --- a/drivers/gemaltomodem/gemaltomodem.c
> > +++ b/drivers/gemaltomodem/gemaltomodem.c
> > @@ -3,6 +3,7 @@
> >    *  oFono - Open Source Telephony
> >    *
> >    *  Copyright (C) 2017 Vincent Cesson. All rights reserved.
> > + *  Copyright (C) 2018 Gemalto M2M
>
> OK, this bugs me enough that I need to comment on it.  I find updating
> the copyright header for patches such as this to be _inappropriate_.
>
> i)  The patch is trivial
> ii)  If everyone who sends a patch updates the copyright header then we
> end up with 300 lines of copyright header in every source file
> iii)  The copyright header barely serves any purpose as it is; as long
> as there is _one_ copyright line in the source then the international
> conventions are applicable in all jurisdictions... i.e. there is never
> any legal reason to add a second copyright line and even the first one
> is mostly not necessary
> iv)  Authorship and ownership are tracked in git in case there are ever
> any issues
> v)  The one thing that the line brings is a bit of credit to an actor
> who does _major_ work on the file in question, so it's ok to add a line
> if you want visible credit for a _significant_ contribution... a bit of
> free advertising for yourself.  But advertising comes at a cost, so the
> contribution should be significant.
>
> Anyway, that's my two bits worth...

According to our licenses experts, the copyright in a file has a
specific meaning:
Whoever is mentioned there has to be consulted before changing the
type of license in a future version of the file.
For the current version is GPLv2, it is given away and won't change.
Should Intel decide to go for a closed license for this file tomorrow,
Gemalto has to be consulted first.

The copyright is something different from the authorship, that can be
consulted, as you point out, in the git log.
Personally I would get rid of the AUTHORS file entirely.

I did not add a copyright note for a 1-line fixes, but I intend to
insert it where the file is specific for gemalto modem or where the
contribution is significant.
At least when done on Gemalto time.

>
> >    *
> >    *  This program is free software; you can redistribute it and/or mod=
ify
> >    *  it under the terms of the GNU General Public License version 2 as
> > @@ -35,12 +36,14 @@
> >   static int gemaltomodem_init(void)
> >   {
> >       gemalto_location_reporting_init();
> > +     gemalto_voicecall_init();
> >
> >       return 0;
> >   }
> >
> >   static void gemaltomodem_exit(void)
> >   {
> > +     gemalto_voicecall_exit();
> >       gemalto_location_reporting_exit();
> >   }
> >
> > diff --git a/drivers/gemaltomodem/gemaltomodem.h b/drivers/gemaltomodem=
/gemaltomodem.h
> > index 7ea1e8fb..c6667411 100644
> > --- a/drivers/gemaltomodem/gemaltomodem.h
> > +++ b/drivers/gemaltomodem/gemaltomodem.h
> > @@ -3,6 +3,7 @@
> >    *  oFono - Open Source Telephony
> >    *
> >    *  Copyright (C) 2017 Vincent Cesson. All rights reserved.
> > + *  Copyright (C) 2018 Gemalto M2M
>
> Ick... consider what you are providing here:  function declarations.
> What does copyright on this mean?

above.

>
> >    *
> >    *  This program is free software; you can redistribute it and/or mod=
ify
> >    *  it under the terms of the GNU General Public License version 2 as
> > @@ -20,6 +21,11 @@
> >    */
> >
> >   #include <drivers/atmodem/atutil.h>
> > +#include "gemaltoutil.h"
> >
> >   extern void gemalto_location_reporting_init();
> >   extern void gemalto_location_reporting_exit();
> > +
> > +extern void gemalto_voicecall_init();
> > +extern void gemalto_voicecall_exit();
> > +
>
> Why are these "extern"?

This is a good question, but to the wrong person, I have been wondering mys=
elf.
My answer is: it has always been done so. See at the end for the full list.

>
> > diff --git a/drivers/gemaltomodem/voicecall.c b/drivers/gemaltomodem/vo=
icecall.c
> > new file mode 100644
> > index 00000000..8e2c7e10
> > --- /dev/null
> > +++ b/drivers/gemaltomodem/voicecall.c
> > @@ -0,0 +1,581 @@
> > +/*
> > + *
> > + *  oFono - Open Source Telephony
> > + *
> > + *  Copyright (C) 2008-2011  Intel Corporation. All rights reserved.
> > + *  Copyright (C) 2018 Gemalto M2M
>
> OK... here the copyright line feels appropriate.

above.

>
> > +
> > +#ifdef HAVE_CONFIG_H
> > +#include <config.h>
> > +#endif
> > +
> > +#define _GNU_SOURCE
>
> What requires _GNU_SOURCE?

I don't know. It was part of drivers/atmodem/voicecall.c.
Maybe Denis knows?

>
> > +
> > +static struct ofono_voicecall_driver driver =3D {
> > +     .name                   =3D "gemaltomodem",
> > +     .probe                  =3D gemalto_voicecall_probe,
> > +     .remove                 =3D gemalto_voicecall_remove,
> > +     .dial                   =3D gemalto_dial,
> > +     .answer                 =3D gemalto_answer,
> > +     .hangup_all             =3D gemalto_hangup_all,
> > +     .hangup_active          =3D gemalto_hangup,
> > +     .hold_all_active        =3D gemalto_hold_all_active,
> > +     .release_all_held       =3D gemalto_release_all_held,
> > +     .set_udub               =3D gemalto_set_udub,
> > +     .release_all_active     =3D gemalto_release_all_active,
> > +     .release_specific       =3D gemalto_release_specific,
> > +     .private_chat           =3D gemalto_private_chat,
> > +     .create_multiparty      =3D gemalto_create_multiparty,
> > +     .transfer               =3D gemalto_transfer,
> > +     .deflect                =3D NULL,
> > +     .swap_without_accept    =3D NULL,
>
> Are other drivers explicit about _not_ providing implementations? I'd
> drop these otherwise?
>

again, it is done so in the original drivers/atmodem/voicecall.c.

>

overall, thank you for reviewing and also for your questions, it gave
me the possibility to clarify some points.

regards,
Giacinto
---
full list of suspicious externs:

drivers/mbimmodem/mbimmodem.h:extern void mbim_devinfo_init(void);
drivers/mbimmodem/mbimmodem.h:extern void mbim_devinfo_exit(void);
drivers/mbimmodem/mbimmodem.h:extern void mbim_sim_init(void);
drivers/mbimmodem/mbimmodem.h:extern void mbim_sim_exit(void);
drivers/mbimmodem/mbimmodem.h:extern void mbim_netreg_init(void);
drivers/mbimmodem/mbimmodem.h:extern void mbim_netreg_exit(void);
drivers/mbimmodem/mbimmodem.h:extern void mbim_sms_init(void);
drivers/mbimmodem/mbimmodem.h:extern void mbim_sms_exit(void);
drivers/mbimmodem/mbimmodem.h:extern void mbim_gprs_init(void);
drivers/mbimmodem/mbimmodem.h:extern void mbim_gprs_exit(void);
drivers/mbimmodem/mbimmodem.h:extern void mbim_gprs_context_init(void);
drivers/mbimmodem/mbimmodem.h:extern void mbim_gprs_context_exit(void);
drivers/dunmodem/dunmodem.h:extern void dun_netreg_init(void);
drivers/dunmodem/dunmodem.h:extern void dun_netreg_exit(void);
drivers/dunmodem/dunmodem.h:extern void dun_gprs_init(void);
drivers/dunmodem/dunmodem.h:extern void dun_gprs_exit(void);
drivers/hsomodem/hsomodem.h:extern void hso_gprs_context_init(void);
drivers/hsomodem/hsomodem.h:extern void hso_gprs_context_exit(void);
drivers/hsomodem/hsomodem.h:extern void hso_radio_settings_init(void);
drivers/hsomodem/hsomodem.h:extern void hso_radio_settings_exit(void);
drivers/swmodem/swmodem.h:extern void sw_gprs_context_init(void);
drivers/swmodem/swmodem.h:extern void sw_gprs_context_exit(void);
drivers/gemaltomodem/gemaltomodem.h:extern void
gemalto_location_reporting_init();
drivers/gemaltomodem/gemaltomodem.h:extern void
gemalto_location_reporting_exit();
drivers/gemaltomodem/gemaltomodem.h:extern void gemalto_voicecall_init();
drivers/gemaltomodem/gemaltomodem.h:extern void gemalto_voicecall_exit();
drivers/nwmodem/nwmodem.h:extern void nw_radio_settings_init(void);
drivers/nwmodem/nwmodem.h:extern void nw_radio_settings_exit(void);
drivers/cdmamodem/cdmamodem.h:extern void cdma_voicecall_init(void);
drivers/cdmamodem/cdmamodem.h:extern void cdma_voicecall_exit(void);
drivers/cdmamodem/cdmamodem.h:extern void cdma_devinfo_init(void);
drivers/cdmamodem/cdmamodem.h:extern void cdma_devinfo_exit(void);
drivers/cdmamodem/cdmamodem.h:extern void cdma_connman_init(void);
drivers/cdmamodem/cdmamodem.h:extern void cdma_connman_exit(void);
drivers/rilmodem/rilmodem.h:extern void ril_devinfo_init(void);
drivers/rilmodem/rilmodem.h:extern void ril_devinfo_exit(void);
drivers/rilmodem/rilmodem.h:extern void ril_call_volume_init(void);
drivers/rilmodem/rilmodem.h:extern void ril_call_volume_exit(void);
drivers/rilmodem/rilmodem.h:extern void ril_voicecall_init(void);
drivers/rilmodem/rilmodem.h:extern void ril_voicecall_exit(void);
drivers/rilmodem/rilmodem.h:extern void ril_sim_init(void);
drivers/rilmodem/rilmodem.h:extern void ril_sim_exit(void);
drivers/rilmodem/rilmodem.h:extern void ril_sms_init(void);
drivers/rilmodem/rilmodem.h:extern void ril_sms_exit(void);
drivers/rilmodem/rilmodem.h:extern void ril_netreg_init(void);
drivers/rilmodem/rilmodem.h:extern void ril_netreg_exit(void);
drivers/rilmodem/rilmodem.h:extern void ril_gprs_init(void);
drivers/rilmodem/rilmodem.h:extern void ril_gprs_exit(void);
drivers/rilmodem/rilmodem.h:extern void ril_gprs_context_init(void);
drivers/rilmodem/rilmodem.h:extern void ril_gprs_context_exit(void);
drivers/rilmodem/rilmodem.h:extern void ril_ussd_init(void);
drivers/rilmodem/rilmodem.h:extern void ril_ussd_exit(void);
drivers/rilmodem/rilmodem.h:extern void ril_call_settings_init(void);
drivers/rilmodem/rilmodem.h:extern void ril_call_settings_exit(void);
drivers/rilmodem/rilmodem.h:extern void ril_call_forwarding_init(void);
drivers/rilmodem/rilmodem.h:extern void ril_call_forwarding_exit(void);
drivers/rilmodem/rilmodem.h:extern void ril_radio_settings_init(void);
drivers/rilmodem/rilmodem.h:extern void ril_radio_settings_exit(void);
drivers/rilmodem/rilmodem.h:extern void ril_call_barring_init(void);
drivers/rilmodem/rilmodem.h:extern void ril_call_barring_exit(void);
drivers/rilmodem/rilmodem.h:extern void ril_phonebook_init(void);
drivers/rilmodem/rilmodem.h:extern void ril_phonebook_exit(void);
drivers/rilmodem/rilmodem.h:extern void ril_netmon_init(void);
drivers/rilmodem/rilmodem.h:extern void ril_netmon_exit(void);
drivers/rilmodem/rilmodem.h:extern void ril_stk_init(void);
drivers/rilmodem/rilmodem.h:extern void ril_stk_exit(void);
drivers/rilmodem/rilmodem.h:extern void ril_cbs_init(void);
drivers/rilmodem/rilmodem.h:extern void ril_cbs_exit(void);
drivers/rilmodem/rilmodem.h:extern void ril_lte_init(void);
drivers/rilmodem/rilmodem.h:extern void ril_lte_exit(void);
drivers/iceramodem/iceramodem.h:extern void icera_gprs_context_init(void);
drivers/iceramodem/iceramodem.h:extern void icera_gprs_context_exit(void);
drivers/iceramodem/iceramodem.h:extern void icera_radio_settings_init(void);
drivers/iceramodem/iceramodem.h:extern void icera_radio_settings_exit(void);
drivers/ubloxmodem/ubloxmodem.h:extern void ublox_gprs_context_init(void);
drivers/ubloxmodem/ubloxmodem.h:extern void ublox_gprs_context_exit(void);
drivers/ubloxmodem/ubloxmodem.h:extern void ublox_netmon_init(void);
drivers/ubloxmodem/ubloxmodem.h:extern void ublox_netmon_exit(void);
drivers/ubloxmodem/ubloxmodem.h:extern void ublox_lte_init(void);
drivers/ubloxmodem/ubloxmodem.h:extern void ublox_lte_exit(void);
drivers/hfpmodem/hfpmodem.h:extern void hfp_netreg_init(void);
drivers/hfpmodem/hfpmodem.h:extern void hfp_netreg_exit(void);
drivers/hfpmodem/hfpmodem.h:extern void hfp_call_volume_init(void);
drivers/hfpmodem/hfpmodem.h:extern void hfp_call_volume_exit(void);
drivers/hfpmodem/hfpmodem.h:extern void hfp_voicecall_init(void);
drivers/hfpmodem/hfpmodem.h:extern void hfp_voicecall_exit(void);
drivers/hfpmodem/hfpmodem.h:extern void hfp_handsfree_init(void);
drivers/hfpmodem/hfpmodem.h:extern void hfp_handsfree_exit(void);
drivers/hfpmodem/hfpmodem.h:extern void hfp_siri_init(void);
drivers/hfpmodem/hfpmodem.h:extern void hfp_siri_exit(void);
drivers/hfpmodem/hfpmodem.h:extern void hfp_devinfo_init(void);
drivers/hfpmodem/hfpmodem.h:extern void hfp_devinfo_exit(void);
drivers/speedupmodem/speedupmodem.h:extern void speedup_ussd_init(void);
drivers/speedupmodem/speedupmodem.h:extern void speedup_ussd_exit(void);
drivers/atmodem/atmodem.h:extern void at_netreg_init(void);
drivers/atmodem/atmodem.h:extern void at_netreg_exit(void);
drivers/atmodem/atmodem.h:extern void at_call_forwarding_init(void);
drivers/atmodem/atmodem.h:extern void at_call_forwarding_exit(void);
drivers/atmodem/atmodem.h:extern void at_call_settings_init(void);
drivers/atmodem/atmodem.h:extern void at_call_settings_exit(void);
drivers/atmodem/atmodem.h:extern void at_ussd_init(void);
drivers/atmodem/atmodem.h:extern void at_ussd_exit(void);
drivers/atmodem/atmodem.h:extern void at_voicecall_init(void);
drivers/atmodem/atmodem.h:extern void at_voicecall_exit(void);
drivers/atmodem/atmodem.h:extern void at_call_meter_init(void);
drivers/atmodem/atmodem.h:extern void at_call_meter_exit(void);
drivers/atmodem/atmodem.h:extern void at_call_barring_init(void);
drivers/atmodem/atmodem.h:extern void at_call_barring_exit(void);
drivers/atmodem/atmodem.h:extern void at_sim_init(void);
drivers/atmodem/atmodem.h:extern void at_sim_exit(void);
drivers/atmodem/atmodem.h:extern void at_stk_init(void);
drivers/atmodem/atmodem.h:extern void at_stk_exit(void);
drivers/atmodem/atmodem.h:extern void at_sms_init(void);
drivers/atmodem/atmodem.h:extern void at_sms_exit(void);
drivers/atmodem/atmodem.h:extern void at_phonebook_init(void);
drivers/atmodem/atmodem.h:extern void at_phonebook_exit(void);
drivers/atmodem/atmodem.h:extern void at_devinfo_init(void);
drivers/atmodem/atmodem.h:extern void at_devinfo_exit(void);
drivers/atmodem/atmodem.h:extern void at_cbs_init(void);
drivers/atmodem/atmodem.h:extern void at_cbs_exit(void);
drivers/atmodem/atmodem.h:extern void at_call_volume_init(void);
drivers/atmodem/atmodem.h:extern void at_call_volume_exit(void);
drivers/atmodem/atmodem.h:extern void at_gprs_init(void);
drivers/atmodem/atmodem.h:extern void at_gprs_exit(void);
drivers/atmodem/atmodem.h:extern void at_gprs_context_init(void);
drivers/atmodem/atmodem.h:extern void at_gprs_context_exit(void);
drivers/atmodem/atmodem.h:extern void at_sim_auth_init(void);
drivers/atmodem/atmodem.h:extern void at_sim_auth_exit(void);
drivers/atmodem/atmodem.h:extern void at_gnss_init(void);
drivers/atmodem/atmodem.h:extern void at_gnss_exit(void);
drivers/atmodem/atmodem.h:extern void at_lte_init(void);
drivers/atmodem/atmodem.h:extern void at_lte_exit(void);
drivers/huaweimodem/huaweimodem.h:extern void huawei_ussd_init(void);
drivers/huaweimodem/huaweimodem.h:extern void huawei_ussd_exit(void);
drivers/huaweimodem/huaweimodem.h:extern void huawei_voicecall_init(void);
drivers/huaweimodem/huaweimodem.h:extern void huawei_voicecall_exit(void);
drivers/huaweimodem/huaweimodem.h:extern void huawei_audio_settings_init(vo=
id);
drivers/huaweimodem/huaweimodem.h:extern void huawei_audio_settings_exit(vo=
id);
drivers/huaweimodem/huaweimodem.h:extern void huawei_radio_settings_init(vo=
id);
drivers/huaweimodem/huaweimodem.h:extern void huawei_radio_settings_exit(vo=
id);
drivers/huaweimodem/huaweimodem.h:extern void huawei_gprs_context_init(void=
);
drivers/huaweimodem/huaweimodem.h:extern void huawei_gprs_context_exit(void=
);
drivers/huaweimodem/huaweimodem.h:extern void huawei_cdma_netreg_init(void);
drivers/huaweimodem/huaweimodem.h:extern void huawei_cdma_netreg_exit(void);
drivers/ifxmodem/ifxmodem.h:extern void ifx_voicecall_init(void);
drivers/ifxmodem/ifxmodem.h:extern void ifx_voicecall_exit(void);
drivers/ifxmodem/ifxmodem.h:extern void ifx_audio_settings_init(void);
drivers/ifxmodem/ifxmodem.h:extern void ifx_audio_settings_exit(void);
drivers/ifxmodem/ifxmodem.h:extern void ifx_radio_settings_init(void);
drivers/ifxmodem/ifxmodem.h:extern void ifx_radio_settings_exit(void);
drivers/ifxmodem/ifxmodem.h:extern void ifx_gprs_context_init(void);
drivers/ifxmodem/ifxmodem.h:extern void ifx_gprs_context_exit(void);
drivers/ifxmodem/ifxmodem.h:extern void ifx_stk_init(void);
drivers/ifxmodem/ifxmodem.h:extern void ifx_stk_exit(void);
drivers/ifxmodem/ifxmodem.h:extern void ifx_ctm_init(void);
drivers/ifxmodem/ifxmodem.h:extern void ifx_ctm_exit(void);
drivers/xmm7modem/xmm7modem.h:extern void xmm_radio_settings_init(void);
drivers/xmm7modem/xmm7modem.h:extern void xmm_radio_settings_exit(void);
drivers/xmm7modem/xmm7modem.h:extern void xmm_ims_init(void);
drivers/xmm7modem/xmm7modem.h:extern void xmm_ims_exit(void);
drivers/xmm7modem/xmm7modem.h:extern void xmm_netmon_init(void);
drivers/xmm7modem/xmm7modem.h:extern void xmm_netmon_exit(void);
drivers/calypsomodem/calypsomodem.h:extern void calypso_voicecall_init(void=
);
drivers/calypsomodem/calypsomodem.h:extern void calypso_voicecall_exit(void=
);
drivers/calypsomodem/calypsomodem.h:extern void calypso_stk_init(void);
drivers/calypsomodem/calypsomodem.h:extern void calypso_stk_exit(void);
drivers/mbmmodem/mbmmodem.h:extern void mbm_gprs_context_init(void);
drivers/mbmmodem/mbmmodem.h:extern void mbm_gprs_context_exit(void);
drivers/mbmmodem/mbmmodem.h:extern void mbm_stk_init(void);
drivers/mbmmodem/mbmmodem.h:extern void mbm_stk_exit(void);
drivers/mbmmodem/mbmmodem.h:extern void mbm_location_reporting_init();
drivers/mbmmodem/mbmmodem.h:extern void mbm_location_reporting_exit();
drivers/isimodem/isimodem.h:extern void isi_phonebook_init(void);
drivers/isimodem/isimodem.h:extern void isi_phonebook_exit(void);
drivers/isimodem/isimodem.h:extern void isi_devinfo_init(void);
drivers/isimodem/isimodem.h:extern void isi_devinfo_exit(void);
drivers/isimodem/isimodem.h:extern void isi_netreg_init(void);
drivers/isimodem/isimodem.h:extern void isi_netreg_exit(void);
drivers/isimodem/isimodem.h:extern void isi_voicecall_init(void);
drivers/isimodem/isimodem.h:extern void isi_voicecall_exit(void);
drivers/isimodem/isimodem.h:extern void isi_sms_init(void);
drivers/isimodem/isimodem.h:extern void isi_sms_exit(void);
drivers/isimodem/isimodem.h:extern void isi_cbs_init(void);
drivers/isimodem/isimodem.h:extern void isi_cbs_exit(void);
drivers/isimodem/isimodem.h:extern void isi_sim_init(void);
drivers/isimodem/isimodem.h:extern void isi_sim_exit(void);
drivers/isimodem/isimodem.h:extern void isi_ussd_init(void);
drivers/isimodem/isimodem.h:extern void isi_ussd_exit(void);
drivers/isimodem/isimodem.h:extern void isi_call_forwarding_init(void);
drivers/isimodem/isimodem.h:extern void isi_call_forwarding_exit(void);
drivers/isimodem/isimodem.h:extern void isi_call_settings_init(void);
drivers/isimodem/isimodem.h:extern void isi_call_settings_exit(void);
drivers/isimodem/isimodem.h:extern void isi_call_barring_init(void);
drivers/isimodem/isimodem.h:extern void isi_call_barring_exit(void);
drivers/isimodem/isimodem.h:extern void isi_call_meter_init(void);
drivers/isimodem/isimodem.h:extern void isi_call_meter_exit(void);
drivers/isimodem/isimodem.h:extern void isi_radio_settings_init(void);
drivers/isimodem/isimodem.h:extern void isi_radio_settings_exit(void);
drivers/isimodem/isimodem.h:extern void isi_gprs_init(void);
drivers/isimodem/isimodem.h:extern void isi_gprs_exit(void);
drivers/isimodem/isimodem.h:extern void isi_gprs_context_init(void);
drivers/isimodem/isimodem.h:extern void isi_gprs_context_exit(void);
drivers/isimodem/isimodem.h:extern void isi_audio_settings_init(void);
drivers/isimodem/isimodem.h:extern void isi_audio_settings_exit(void);
drivers/isimodem/isimodem.h:extern void isi_uicc_init(void);
drivers/isimodem/isimodem.h:extern void isi_uicc_exit(void);
drivers/stemodem/stemodem.h:extern void ste_gprs_context_init(void);
drivers/stemodem/stemodem.h:extern void ste_gprs_context_exit(void);
drivers/stemodem/stemodem.h:extern void ste_voicecall_init(void);
drivers/stemodem/stemodem.h:extern void ste_voicecall_exit(void);
drivers/stemodem/stemodem.h:extern void ste_radio_settings_init(void);
drivers/stemodem/stemodem.h:extern void ste_radio_settings_exit(void);
drivers/qmimodem/qmimodem.h:extern void qmi_devinfo_init(void);
drivers/qmimodem/qmimodem.h:extern void qmi_devinfo_exit(void);
drivers/qmimodem/qmimodem.h:extern void qmi_netreg_init(void);
drivers/qmimodem/qmimodem.h:extern void qmi_netreg_exit(void);
drivers/qmimodem/qmimodem.h:extern void qmi_voicecall_init(void);
drivers/qmimodem/qmimodem.h:extern void qmi_voicecall_exit(void);
drivers/qmimodem/qmimodem.h:extern void qmi_sim_legacy_init(void);
drivers/qmimodem/qmimodem.h:extern void qmi_sim_legacy_exit(void);
drivers/qmimodem/qmimodem.h:extern void qmi_sim_init(void);
drivers/qmimodem/qmimodem.h:extern void qmi_sim_exit(void);
drivers/qmimodem/qmimodem.h:extern void qmi_sms_init(void);
drivers/qmimodem/qmimodem.h:extern void qmi_sms_exit(void);
drivers/qmimodem/qmimodem.h:extern void qmi_ussd_init(void);
drivers/qmimodem/qmimodem.h:extern void qmi_ussd_exit(void);
drivers/qmimodem/qmimodem.h:extern void qmi_gprs_init(void);
drivers/qmimodem/qmimodem.h:extern void qmi_gprs_exit(void);
drivers/qmimodem/qmimodem.h:extern void qmi_gprs_context_init(void);
drivers/qmimodem/qmimodem.h:extern void qmi_gprs_context_exit(void);
drivers/qmimodem/qmimodem.h:extern void qmi_lte_init(void);
drivers/qmimodem/qmimodem.h:extern void qmi_lte_exit(void);
drivers/qmimodem/qmimodem.h:extern void qmi_radio_settings_init(void);
drivers/qmimodem/qmimodem.h:extern void qmi_radio_settings_exit(void);
drivers/qmimodem/qmimodem.h:extern void qmi_location_reporting_init(void);
drivers/qmimodem/qmimodem.h:extern void qmi_location_reporting_exit(void);
drivers/qmimodem/qmimodem.h:extern void qmi_netmon_init(void);
drivers/qmimodem/qmimodem.h:extern void qmi_netmon_exit(void);
drivers/ztemodem/ztemodem.h:extern void zte_radio_settings_init(void);
drivers/ztemodem/ztemodem.h:extern void zte_radio_settings_exit(void);
drivers/telitmodem/telitmodem.h:extern void telit_location_reporting_init();
drivers/telitmodem/telitmodem.h:extern void telit_location_reporting_exit();
drivers/telitmodem/telitmodem.h:extern void telitncm_gprs_context_init();
drivers/telitmodem/telitmodem.h:extern void telitncm_gprs_context_exit();

--===============8717139683298394004==--

