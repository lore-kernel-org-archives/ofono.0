Content-Type: multipart/mixed; boundary="===============0434693722664439342=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH v2 1/3] qmi: add LTE atom driver
Date: Fri, 02 Mar 2018 10:36:05 -0600
Message-ID: <0bb0e70b-cb10-3828-73da-86442dbf1051@gmail.com>
In-Reply-To: <20180302151221.18063-2-jonas@southpole.se>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0434693722664439342==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Jonas,

On 03/02/2018 09:12 AM, Jonas Bonn wrote:
> This patch adds an LTE atom for QMI modems.
> =

> This atom sets the APN that the LTE default bearer should use when
> establishing its PDP context.  This APN needs to be set on the 'default'
> profile so the atom queries which profile is the default and resets
> it before allowing the APN to be set.
> =

> Once configured, the default profile settings are used when the
> modem connects to the network; for this reason, the LTE atom needs
> to be instantiated in post_sim, before the modem is set online.
> ---
>   Makefile.am                 |   1 +
>   drivers/qmimodem/lte.c      | 266 +++++++++++++++++++++++++++++++++++++=
+++++++
>   drivers/qmimodem/qmimodem.c |   2 +
>   drivers/qmimodem/qmimodem.h |   3 +
>   4 files changed, 272 insertions(+)
>   create mode 100644 drivers/qmimodem/lte.c

So this looks good to me.  Since Reinhard has provided invaluable =

insight into how QMI works in the past and seems to have 'insider' =

knowledge, maybe we can get him to also comment on whether the approach =

is correct (e.g. whether querying / setting the default profile is =

equivalent to setting the default LTE attach parameters) or if there's =

another QMI command that should be used.

Otherwise a few minor nitpicks below, I can fix these or you can:

<snip>

> +static void reset_profile_cb(struct qmi_result *result, void *user_data)
> +{
> +	struct ofono_lte *lte =3D user_data;
> +	uint16_t error;
> +
> +	DBG("");
> +
> +	if (qmi_result_set_error(result, &error)) {
> +		ofono_error("Reset profile error: %hd", error);
> +	}

No {} please

> +
> +	ofono_lte_register(lte);
> +}
> +
> +static void get_default_profile_cb(struct qmi_result *result, void *user=
_data)
> +{
> +	struct ofono_lte *lte =3D user_data;
> +	struct lte_data *ldd =3D ofono_lte_get_data(lte);
> +	uint16_t error;
> +	uint8_t index;
> +	struct qmi_param* param;

*param

> +	struct {
> +		uint8_t type;
> +		uint8_t index;
> +	} __attribute__((packed)) p =3D {
> +		.type =3D 0, /* 3GPP */
> +	};
> +
> +	DBG("");
> +
> +	if (qmi_result_set_error(result, &error)) {
> +		ofono_error("Get default profile error: %hd", error);
> +		goto error;
> +	}
> +
> +	/* Profile index */
> +	if (!qmi_result_get_uint8(result, 0x01, &index)) {
> +		ofono_error("Failed query default profile");
> +		goto error;
> +	}
> +
> +	DBG("Default profile index: %hhd", index);
> +
> +	ldd->default_profile =3D index;
> +
> +	p.index =3D index;
> +
> +	param =3D qmi_param_new();
> +	if (!param)
> +		goto error;
> +
> +	/* Profile selector */
> +	qmi_param_append(param, 0x01, sizeof(p), &p);
> +
> +	/* Reset profile */
> +	if (qmi_service_send(ldd->wds, 0x4b, param,
> +				reset_profile_cb, lte, NULL) > 0)
> +		return;
> +
> +	qmi_param_free(param);
> +
> +error:
> +	ofono_error("Failed to reset profile %hhd", index);
> +	ofono_lte_register(lte);

Do you actually want to register here still or remove the atom instead?

> +}
> +
> +

no double empty lines please

> +static void create_wds_cb(struct qmi_service *service, void *user_data)
> +{
> +	struct ofono_lte *lte =3D user_data;
> +	struct lte_data *ldd =3D ofono_lte_get_data(lte);
> +	struct qmi_param* param;

*param

> +	struct {
> +		uint8_t type;
> +		uint8_t family;
> +	} __attribute((packed)) p =3D {
> +		.type =3D 0,   /* 3GPP */
> +		.family =3D 0, /* embedded */
> +	};
> +
> +	DBG("");
> +
> +	if (!service) {
> +		ofono_error("Failed to request WDS service");
> +		ofono_lte_remove(lte);
> +		return;
> +	}
> +
> +	ldd->wds =3D qmi_service_ref(service);
> +
> +	/* Query the default profile */
> +	param =3D qmi_param_new();
> +	if (!param)
> +		goto error;
> +
> +	/* Profile type */
> +	qmi_param_append(param, 0x1, sizeof(p), &p);
> +
> +	/* Get default profile */
> +	if (qmi_service_send(ldd->wds, 0x49, param,
> +				get_default_profile_cb, lte, NULL) > 0)
> +		return;
> +
> +	qmi_param_free(param);
> +
> +error:
> +	ofono_error("Failed to query default profile");
> +	ofono_lte_register(lte);
> +}

<snip>

Regards,
-Denis

--===============0434693722664439342==--

