Content-Type: multipart/mixed; boundary="===============9045518462931107241=="
MIME-Version: 1.0
From: Jeevaka.Badrappan@elektrobit.com
Subject: RE: [PATCH] sim: Ensure to call sim_pin_check
Date: Wed, 25 Aug 2010 16:12:30 +0300
Message-ID: <B668883EB5DD7144ADFC248A72176EA8029A8687@fioues07.ebgroup.elektrobit.com>
In-Reply-To: <1282732136-7468-1-git-send-email-yang.gu@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============9045518462931107241==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Yang Gu, =


> In current code, sim_pin_check() is called inside sim_efpl_read_cb().
> However, there may be a chance it would never be called, thus the
modem won't be initialized correctly.
> ---
>  src/sim.c |    4 ++--
>  1 files changed, 2 insertions(+), 2 deletions(-)

> diff --git a/src/sim.c b/src/sim.c
> index a450b30..9bc9906 100644
> --- a/src/sim.c
> +++ b/src/sim.c
> @@ -1380,8 +1380,6 @@ skip_efpl:
>  						"PreferredLanguages",
>  						DBUS_TYPE_STRING,
>  						&sim->language_prefs);
> -
> -	sim_pin_check(sim);
>  }
 =

>  static void sim_iccid_read_cb(int ok, int length, int record, @@
-1454,6 +1452,8 @@ static void sim_initialize(struct ofono_sim *sim)
>  	ofono_sim_read(sim, SIM_EFPL_FILEID,
>  			OFONO_SIM_FILE_STRUCTURE_TRANSPARENT,
>  			sim_efpl_read_cb, sim);
> +
> +	sim_pin_check(sim);
>  }
 =

>  static void sim_op_error(struct ofono_sim *sim)
> --
> 1.7.0.4

As per the 3GPP 31.102 section 5.1.1.2, CHV1 verification procedure will
be done after reading of EFli and EFpl. Earlier( before "sim: Reorder
SIM initialization" patch) src/sim.c had the sim_pin_check()called from
sim_efphase_read_cb() where it called after issuing EFli and EFpl file
read request. The patch "sim: Reorder SIM initialization" changed it to
call from sim_efpl_read_cb() which is as per the specification.If the
reading of EFli and EFpl fails, then sim_pin_check is not getting called
because we are returning from "if (sim->language_prefs =3D=3D NULL)". In
your patch, you are moving it to be called after the EFpl read request
which is same as what we had before "sim: Reorder SIM initialization"
patch. I believe the right place to call the sim_pin_check() will be
before the if condition(if (sim->language_prefs =3D=3D NULL)) in
sim_efpl_read_cb(), like shown below

      if (efpl) {
		g_slist_foreach(efpl, (GFunc)g_free, NULL);
	      g_slist_free(efpl);
 	}
	=

	sim_pin_check(sim);

      if (sim->language_prefs =3D=3D NULL)
            return;

      ofono_dbus_signal_array_property_changed(conn, path,
 =

OFONO_SIM_MANAGER_INTERFACE,
                                               "PreferredLanguages",
                                               DBUS_TYPE_STRING,
                                               &sim->language_prefs);

Let me know your views on this.

Thanks and Regards,
jeevaka
_______________________________________________
ofono mailing list
ofono(a)ofono.org
http://lists.ofono.org/listinfo/ofono


----------------------------------------------------------------
Please note: This e-mail may contain confidential information
intended solely for the addressee. If you have received this
e-mail in error, please do not disclose it to anyone, notify
the sender promptly, and delete the message from your system.
Thank you.



----------------------------------------------------------------
Please note: This e-mail may contain confidential information
intended solely for the addressee. If you have received this
e-mail in error, please do not disclose it to anyone, notify
the sender promptly, and delete the message from your system.
Thank you.


--===============9045518462931107241==--

