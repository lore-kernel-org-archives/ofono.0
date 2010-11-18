Content-Type: multipart/mixed; boundary="===============1626075047374873723=="
MIME-Version: 1.0
From: Jeevaka.Badrappan@elektrobit.com
Subject: RE: [PATCH 1/2] stk: provide access technology info
Date: Thu, 18 Nov 2010 15:36:56 +0200
Message-ID: <B668883EB5DD7144ADFC248A72176EA802C076BD@fioues07.ebgroup.elektrobit.com>
In-Reply-To: <1290077756-28124-2-git-send-email-yang.gu@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1626075047374873723==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Yang,
 =

> +
> +unsigned int __ofono_netreg_get_tech(struct ofono_netreg *netreg) {
> +	GSList *o;
> +	unsigned int techs =3D 0;
> +	struct network_operator_data *opd;
> +
> +	for (o =3D netreg->operator_list; o; o =3D o->next) {
> +		opd =3D o->data;
> +		techs |=3D opd->techs;
> +	}
> +
> +	return techs;
> +}

Is this function intended to get the current access technology?  =


As per the ETSI TS 102 223 specification 4.12 section, when the SAT
issues Provide Local Information proactive command with Access
Technology(0x06) as the command qualifier, we should provide the current
access technology . So, as per my understanding we need to use
netreg->technology. =


> void __ofono_netreg_set_base_station_name(struct ofono_netreg *netreg,
> 						const char *name);
> +unsigned int __ofono_netreg_get_tech(struct ofono_netreg *netreg);
 =

Empty line needed between __ofono_netreg_set_base_station_name and
__ofono_netreg_get_tech

Regards,
Jeevaka

--===============1626075047374873723==--

