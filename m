Content-Type: multipart/mixed; boundary="===============6628727244513918518=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 17/18] isimodem: CBS for wgmodem2.5
Date: Wed, 16 Feb 2011 10:10:32 -0600
Message-ID: <4D5BF6F8.9080506@gmail.com>
In-Reply-To: <d01065fc1a0d34feedf665921f2fe4270850af4d.1297772944.git.andreas.westin@stericsson.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6628727244513918518==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Andreas,

> +static void reset_buf(char *buf, char *buf_2, int buf_len)
> +{
> +	memset(buf, '\0', buf_len);
> +	memset(buf_2, '\0', buf_len);
> +}
> +
> +static int get_topics_len(const char *topics)
> +{
> +	int i =3D 0;
> +	int k =3D 0;
> +	int length =3D 0;
> +	char buf[6];
> +	char buf_2[6];
> +
> +	reset_buf(buf, buf_2, 6);
> +
> +	while (*topics !=3D '\0') {
> +		if (*topics =3D=3D ',') {
> +			reset_buf(buf, buf_2, 6);
> +			k =3D 0;
> +			length++;
> +		} else if (*topics !=3D ',' && *topics !=3D '-') {
> +			buf[k] =3D *topics;
> +			k++;
> +		} else if (*topics =3D=3D '-') {
> +			topics++;
> +			i++;
> +			k =3D 0;
> +
> +			while (*topics !=3D ',' && *topics !=3D '\0') {
> +				buf_2[k] =3D *topics;
> +				topics++;
> +				i++;
> +				k++;
> +			}
> +
> +			length =3D length + atoi(buf_2) - atoi(buf) + 1;
> +			k =3D 0;
> +		}
> +
> +		topics++;
> +		i++;
> +	}
> +
> +	topics =3D topics - i;
> +	return length;
> +}
> +
> +static void parse_topics(const char *topics, gint16 *topics_parsed)
> +{
> +	int j =3D 0;
> +	int k =3D 0;
> +	char buf[6];
> +	char buf_2[6];
> +
> +	reset_buf(buf, buf_2, 6);
> +
> +	while (*topics !=3D '\0') {
> +		if (*topics !=3D ',' && *topics !=3D '-') {
> +			buf[j] =3D *topics;
> +			j++;
> +		} else if (*topics =3D=3D '-') {
> +			topics++;
> +			j =3D 0;
> +
> +			while (*topics !=3D ',' && *topics !=3D '\0') {
> +				buf_2[j] =3D *topics;
> +				topics++;
> +				j++;
> +			}
> +
> +			for (j =3D 0; j <=3D (atoi(buf_2) - atoi(buf)); j++) {
> +				topics_parsed[k] =3D atoi(buf) + j;
> +				topics_parsed[k] =3D g_ntohs(topics_parsed[k]);
> +				k++;
> +			}
> +
> +			j =3D 0;
> +		} else if (*topics =3D=3D ',') {
> +			topics_parsed[k] =3D atoi(buf);
> +			topics_parsed[k] =3D g_ntohs(topics_parsed[k]);
> +			reset_buf(buf, buf_2, 6);
> +			j =3D 0;
> +			k++;
> +		}
> +
> +		topics++;
> +	}
> +}
> +

Have you thought of adapting cbs_extract_topic_ranges function for all
of this somehow?

Regards,
-Denis

--===============6628727244513918518==--

