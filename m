Content-Type: multipart/mixed; boundary="===============5357199763874058350=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: GPRS provisioning is broken for old (non-USIM) SIM cards
Date: Tue, 02 Dec 2014 11:30:17 -0600
Message-ID: <547DF729.1000401@gmail.com>
In-Reply-To: <547C5386.3090400@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5357199763874058350==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Alexey,

On 12/01/2014 05:39 AM, Alexey Mednyy wrote:
> year old patch from ubuntu's ofono flavor.
> commit d9b8a16f0878868396bbecb61941d0325f07e662
> Author: Alfonso Sanchez-Beato <alfonsosanchezbeato@yahoo.es>
> Date:   Wed Oct 2 09:49:46 2013 +0200
>
>      Fix for LP #1231320: GPRS provisioning is broken for old (non-USIM)
> SIM cards in Ubuntu
>

Please follow the patch submission guidelines.  See HACKING, "Submitting =

Patches" for more details.

> diff --git a/include/sim.h b/include/sim.h
> index ed850f9..f63324a 100644
> --- a/include/sim.h
> +++ b/include/sim.h
> @@ -191,6 +191,7 @@ void *ofono_sim_get_data(struct ofono_sim *sim);
>   const char *ofono_sim_get_imsi(struct ofono_sim *sim);
>   const char *ofono_sim_get_mcc(struct ofono_sim *sim);
>   const char *ofono_sim_get_mnc(struct ofono_sim *sim);
> +unsigned ofono_sim_get_mnc_length(struct ofono_sim *sim);
>   const char *ofono_sim_get_spn(struct ofono_sim *sim);
>   enum ofono_sim_phase ofono_sim_get_phase(struct ofono_sim *sim);
>
> diff --git a/plugins/provision.c b/plugins/provision.c
> index 4e9e2a7..78f4f5b 100644
> --- a/plugins/provision.c
> +++ b/plugins/provision.c
> @@ -48,7 +48,7 @@ static int provision_get_settings(const char *mcc,
> const char *mnc,
>          int ap_count;
>          int i;
>
> -       DBG("Provisioning for MCC %s, MNC %s, SPN '%s'", mcc, mnc, spn);
> +       ofono_info("Provisioning for MCC %s, MNC %s, SPN '%s'", mcc,
> mnc, spn);
>
>          /*
>           * TODO: review with upstream.  Default behavior was to
> diff --git a/src/gprs.c b/src/gprs.c
> index e379f7b..0218696 100644
> --- a/src/gprs.c
> +++ b/src/gprs.c
> @@ -2967,7 +2967,7 @@ static void provision_context(const struct
> ofono_gprs_provision_data *ap,
>          gprs->contexts =3D g_slist_append(gprs->contexts, context);
>   }
>
> -static void provision_contexts(struct ofono_gprs *gprs, const char *mcc,
> +static int provision_contexts(struct ofono_gprs *gprs, const char *mcc,
>                                  const char *mnc, const char *spn)
>   {
>          struct ofono_gprs_provision_data *settings;
> @@ -2977,13 +2977,15 @@ static void provision_contexts(struct ofono_gprs
> *gprs, const char *mcc,
>          if (__ofono_gprs_provision_get_settings(mcc, mnc, spn,
>                                                  &settings, &count) =3D=
=3D
> FALSE) {
>                  ofono_warn("Provisioning failed");
> -               return;
> +               return -EINVAL;
>          }
>
>          for (i =3D 0; i < count; i++)
>                  provision_context(&settings[i], gprs);
>
>          __ofono_gprs_provision_free_settings(settings, count);
> +
> +       return 0;
> +       ofono_dbus_signal_property_changed(conn, path,
> +       ofono_dbus_signal_property_changed(conn, path,
> +                                       OFONO_SIM_MANAGER_INTERFACE,
> +                                       "MobileNetworkCode",
> +                                       DBUS_TYPE_STRING, &str);

This looks bogus.  Also, the GPRS atom should not be signaling =

properties of the sim atom.  So this is a NAK.

>
>          sim_set_ready(sim);
>
> @@ -1772,8 +1783,12 @@ static void sim_ad_read_cb(int ok, int length,
> int record,
>          if (!ok)
>                  return;
>
> +       if (length < 3) {
> +               ofono_error("EFad should contain at least three bytes");
> +               return;
> +       }
>          if (length < 4) {
> -               ofono_error("EFad should contain at least four bytes");
> +               ofono_info("EFad does not contain MNC length");
>                  return;

Improper whitespace, we do not use spaces for indentation.

>          }
>
> @@ -2234,6 +2249,14 @@ const char *ofono_sim_get_mnc(struct ofono_sim *si=
m)
>          return sim->mnc;
>   }
>
> +unsigned ofono_sim_get_mnc_length(struct ofono_sim *sim)
> +{
> +       if (sim =3D=3D NULL)
> +               return 0;
> +
> +       return sim->mnc_length;
> +}
> +

What is the purpose of this function?  Either way, it should be in a =

standalone patch.

>   const char *ofono_sim_get_spn(struct ofono_sim *sim)
>   {
>          if (sim =3D=3D NULL)
>

Regards,
-Denis

--===============5357199763874058350==--

