Content-Type: multipart/mixed; boundary="===============3782664413766662517=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [RFC PATCH 2/3] ssn: add code and call id to notifications
Date: Wed, 09 Feb 2011 21:08:04 -0600
Message-ID: <4D535694.3030505@gmail.com>
In-Reply-To: <a562a3e40e5acbb640fefca65b33e3bdf4d6e61b.1297244230.git.Andras.Domokos@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3782664413766662517==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Andras,

> diff --git a/include/ssn.h b/include/ssn.h
> index d640cad..ba3701b 100644
> --- a/include/ssn.h
> +++ b/include/ssn.h
> @@ -37,9 +37,10 @@ struct ofono_ssn_driver {
>  };
>  =

>  /* SSN notifications (CSSI and CSSU).  */
> -void ofono_ssn_cssi_notify(struct ofono_ssn *ssn, int code, int index);
> -void ofono_ssn_cssu_notify(struct ofono_ssn *ssn, int code, int index,
> -				const struct ofono_phone_number *number);
> +void ofono_ssn_cssi_notify(struct ofono_ssn *ssn, unsigned int id,
> +				int code1, int index);
> +void ofono_ssn_cssu_notify(struct ofono_ssn *ssn, unsigned int id, int c=
ode2,
> +			int index, const struct ofono_phone_number *number);
>  =

>  int ofono_ssn_driver_register(const struct ofono_ssn_driver *d);
>  void ofono_ssn_driver_unregister(const struct ofono_ssn_driver *d);

Right now I'm not seeing any users (or even potential ones) of the SSN
atom besides voicecall.  What do you think of removing the SSN atom and
moving these to the voicecall atom?

The only one I'm not sure about is <code2> from 27.007:
6	forward check SS message received (can be received whenever)

Any idea what this one is about?

Regards,
-Denis

--===============3782664413766662517==--

