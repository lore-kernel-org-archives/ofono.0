Content-Type: multipart/mixed; boundary="===============3553782180746239492=="
MIME-Version: 1.0
From: Soum, RedouaneX <redouanex.soum@intel.com>
Subject: RE: [RFC PATCH] gprs: add function to handle activated context
Date: Thu, 06 Jan 2011 14:59:06 +0000
Message-ID: <8281606748F03E4390BB98A3F47F2E948A9C123FBC@irsmsx501.ger.corp.intel.com>
In-Reply-To: <AANLkTimxkKAjcEdS9hGLECWEaW4o+ygPU3RCikFpcK0i@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3553782180746239492==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Sjur,


> > +static void gprs_cid_take(struct ofono_gprs *gprs, unsigned int id)
> > +{
> > + =C2=A0 =C2=A0 =C2=A0 idmap_take(gprs->cid_map, id);
> > +}
> > +
> How do we assure that this CID is not already in use?
> I think the M7400 is going to use CID=3D0 and M700 uses CID=3D1.
> Perhaps we should make sure CID=3D0 is a legal value and reserve CID 0
> and 1 at start up.

From my understanding the ID in the core is an internal ID for oFono core, =
even if today we usually have a mapping 1 to 1 between oFono core ID and mo=
dems CID.
Denis, Marcel could you confirm ?

In this case the CID parameter in ofono_gprs_context_activated should be ou=
t parameter and renamed as ID.

---
void ofono_gprs_context_activated(struct ofono_gprs_context *gc,
		int *id, const char *apn,
		const char *interface, ofono_bool_t static_ip,
		const char *address, const char *netmask,
		const char *gw, const char **dns)
---


Also if we look to ofono_gprs_context_deactivated function the parameter us=
ed is ID and not CID, maybe it'll be beter if we rename cid in ofono_gprs_p=
rimary_context structure to avoid confusion : =


----
struct ofono_gprs_primary_context {
	unsigned int id;
	int direction;
	char apn[OFONO_GPRS_MAX_APN_LENGTH + 1];
	char username[OFONO_GPRS_MAX_USERNAME_LENGTH + 1];
	char password[OFONO_GPRS_MAX_PASSWORD_LENGTH + 1];
	enum ofono_gprs_proto proto;
};
----


If we try to do something else oFono core will be modem dependent and it's =
really not a good idea.


Regards,

---------------------------------------------------------------------
Intel Corporation SAS (French simplified joint stock company)
Registered headquarters: "Les Montalets"- 2, rue de Paris, =

92196 Meudon Cedex, France
Registration Number:  302 456 199 R.C.S. NANTERRE
Capital: 4,572,000 Euros

This e-mail and any attachments may contain confidential material for
the sole use of the intended recipient(s). Any review or distribution
by others is strictly prohibited. If you are not the intended
recipient, please contact the sender and delete all copies.

--===============3553782180746239492==--

