Content-Type: multipart/mixed; boundary="===============1838109329870933660=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 1/5] Add SIM authentication atom's driver definitions.
Date: Tue, 18 Jan 2011 13:21:30 -0600
Message-ID: <4D35E83A.3030104@gmail.com>
In-Reply-To: <1295285934-9306-1-git-send-email-andrew.zaborowski@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1838109329870933660==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Andrew,

> +typedef void (*ofono_sim_list_apps_cb_t)(const struct ofono_error *error,
> +					struct ofono_sim_app_record *list,
> +					int count, void *data);

So I've been thinking about this one.  Was there a reason why you want
to pass the parsed list out of the driver instead of just returning the
hex_decoded CUAD response and length?

If we do that then:

> +struct ofono_sim_app_record {
> +	unsigned char aid[16];
> +	int aid_len;
> +	char *label;
> +};

Can be easily hidden inside simutil.h and not exposed to the outside world.

Regards,
-Denis

--===============1838109329870933660==--

