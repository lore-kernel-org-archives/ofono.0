Content-Type: multipart/mixed; boundary="===============3080677765695401657=="
MIME-Version: 1.0
From: Aki Niemi <aki@protocolpolice.com>
Subject: Re: [PATCH 3/4] isimodem2.5: Changes to add isimodem2.5
Date: Thu, 09 Dec 2010 08:26:43 +0200
Message-ID: <AANLkTinXYaMie6MrsK6gWyfwtYAeN6d46-iy1j-Px3pY@mail.gmail.com>
In-Reply-To: <1291797294-20554-1-git-send-email-jessica.j.nilsson@stericsson.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3080677765695401657==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Jessica,

2010/12/8 Jessica Nilsson <jessica.j.nilsson@stericsson.com>:
> +static void reset_buf(char *buf, char *buf_2, int buf_len)
> +{
> + =C2=A0 =C2=A0 =C2=A0 memset(buf, '\0', buf_len);
> + =C2=A0 =C2=A0 =C2=A0 memset(buf_2, '\0', buf_len);
> +}
> +
> +static int get_topics_len(const char *topics)
> +{
> + =C2=A0 =C2=A0 =C2=A0 int i =3D 0;
> + =C2=A0 =C2=A0 =C2=A0 int k =3D 0;
> + =C2=A0 =C2=A0 =C2=A0 int length =3D 0;
> + =C2=A0 =C2=A0 =C2=A0 char buf[6];
> + =C2=A0 =C2=A0 =C2=A0 char buf_2[6];
> +
> + =C2=A0 =C2=A0 =C2=A0 reset_buf(buf, buf_2, 6);
> +
> + =C2=A0 =C2=A0 =C2=A0 while (*topics !=3D '\0') {
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (*topics =3D=3D ','=
) {
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 reset_buf(buf, buf_2, 6);
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 k =3D 0;
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 length++;
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 } else if (*topics !=
=3D ',' && *topics !=3D '-') {
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 buf[k] =3D *topics;
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 k++;
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 } else if (*topics =3D=
=3D '-') {
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 topics++;
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 i++;
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 k =3D 0;
> +
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 while (*topics !=3D ',' && *topics !=3D '\0') {
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 buf_2[k] =3D *topics;
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 topics++;
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 i++;
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 k++;
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 }
> +
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 length =3D length + atoi(buf_2) - atoi(buf) + 1;
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 k =3D 0;
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }
> +
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 topics++;
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 i++;
> + =C2=A0 =C2=A0 =C2=A0 }
> +
> + =C2=A0 =C2=A0 =C2=A0 topics =3D topics - i;
> + =C2=A0 =C2=A0 =C2=A0 return length;
> +}
> +
> +static void parse_topics(const char *topics, gint16 *topics_parsed)
> +{
> + =C2=A0 =C2=A0 =C2=A0 int j =3D 0;
> + =C2=A0 =C2=A0 =C2=A0 int k =3D 0;
> + =C2=A0 =C2=A0 =C2=A0 char buf[6];
> + =C2=A0 =C2=A0 =C2=A0 char buf_2[6];
> +
> + =C2=A0 =C2=A0 =C2=A0 reset_buf(buf, buf_2, 6);
> +
> + =C2=A0 =C2=A0 =C2=A0 while (*topics !=3D '\0') {
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (*topics !=3D ',' &=
& *topics !=3D '-') {
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 buf[j] =3D *topics;
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 j++;
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 } else if (*topics =3D=
=3D '-') {
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 topics++;
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 j =3D 0;
> +
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 while (*topics !=3D ',' && *topics !=3D '\0') {
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 buf_2[j] =3D *topics;
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 topics++;
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 j++;
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 }
> +
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 for (j =3D 0; j <=3D (atoi(buf_2) - atoi(buf)); j++) {
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 topics_parsed[k] =3D atoi(buf) + j;
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 topics_parsed[k] =3D g_ntohs(topics_pars=
ed[k]);
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 k++;
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 }
> +
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 j =3D 0;
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 } else if (*topics =3D=
=3D ',') {
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 topics_parsed[k] =3D atoi(buf);
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 topics_parsed[k] =3D g_ntohs(topics_parsed[k]);
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 reset_buf(buf, buf_2, 6);
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 j =3D 0;
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 k++;
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }
> +
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 topics++;
> + =C2=A0 =C2=A0 =C2=A0 }
> +}
> +
> +static gboolean set_resp_cb(GIsiClient *client, const void *restrict dat=
a,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 size_t len, uint16_t object, void *opaqu=
e)
> +{
> + =C2=A0 =C2=A0 =C2=A0 const unsigned char *msg =3D data;
> + =C2=A0 =C2=A0 =C2=A0 struct isi_cb_data *cbd =3D opaque;
> + =C2=A0 =C2=A0 =C2=A0 ofono_cbs_set_cb_t cb =3D cbd->cb;
> +
> + =C2=A0 =C2=A0 =C2=A0 DBG("");
> +
> + =C2=A0 =C2=A0 =C2=A0 if (!msg) {
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 DBG("ISI client error:=
 %d", g_isi_client_error(client));
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 goto error;
> + =C2=A0 =C2=A0 =C2=A0 }
> +
> + =C2=A0 =C2=A0 =C2=A0 if (len < 3 || msg[0] !=3D SMS_CB_ROUTING_RESP)
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 goto error;
> +
> + =C2=A0 =C2=A0 =C2=A0 if (msg[2] !=3D SMS_OK)
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 goto error;
> +
> + =C2=A0 =C2=A0 =C2=A0 cbs_subscription_nr =3D msg[1];
> + =C2=A0 =C2=A0 =C2=A0 CALLBACK_WITH_SUCCESS(cb, cbd->data);
> + =C2=A0 =C2=A0 =C2=A0 goto out;
> +error:
> + =C2=A0 =C2=A0 =C2=A0 CALLBACK_WITH_FAILURE(cb, cbd->data);
> +out:
> + =C2=A0 =C2=A0 =C2=A0 g_free(cbd);
> + =C2=A0 =C2=A0 =C2=A0 return TRUE;
> +}
> +
> +static void isi_set_topics(struct ofono_cbs *cbs, const char *topics,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ofono_cbs_set_cb_t cb, void *data)
> +{
> + =C2=A0 =C2=A0 =C2=A0 struct cbs_data *cd =3D ofono_cbs_get_data(cbs);
> + =C2=A0 =C2=A0 =C2=A0 struct isi_cb_data *cbd =3D isi_cb_data_new(cbs, c=
b, data);
> + =C2=A0 =C2=A0 =C2=A0 int topics_len =3D get_topics_len(topics);
> + =C2=A0 =C2=A0 =C2=A0 gint16 topics_out[topics_len];
> +
> + =C2=A0 =C2=A0 =C2=A0 uint8_t msg[] =3D {
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 SMS_CB_ROUTING_REQ,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 SMS_ROUTING_SET,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 cbs_subscription_nr,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0x00, =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /*Subscription type*/
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0x00, =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /*Fillers*/
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0x00,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0x01, =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /*Number of subblocks*/
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0x00,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0x26, =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /*Subblock*/
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0x00,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 topics_len * 2 + 6, =
=C2=A0 =C2=A0 /*Subblock length*/
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0x00,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 topics_len, =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /*Number of topics*/
> + =C2=A0 =C2=A0 =C2=A0 };
> + =C2=A0 =C2=A0 =C2=A0 struct iovec iov[2] =3D {
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 { msg, sizeof(msg) },
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 { topics_out, sizeof(t=
opics_out) },
> + =C2=A0 =C2=A0 =C2=A0 };
> + =C2=A0 =C2=A0 =C2=A0 parse_topics(topics, topics_out);
> +
> + =C2=A0 =C2=A0 =C2=A0 DBG("");
> +
> + =C2=A0 =C2=A0 =C2=A0 if (g_isi_request_vmake(cd->client, iov, 2, CBS_TI=
MEOUT,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 set_resp_cb, cbd))
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return;
> +
> + =C2=A0 =C2=A0 =C2=A0 CALLBACK_WITH_FAILURE(cb, data);
> + =C2=A0 =C2=A0 =C2=A0 g_free(cbd);
> +}

The CBS topics set is simply not implemented in the current cbs
driver. I suggest you create a patch for adding that into the current
driver.

> +static gboolean clear_resp_cb(GIsiClient *client, const void *restrict d=
ata,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 size_t len, uint16_t object, void *opaqu=
e)
> +{
> + =C2=A0 =C2=A0 =C2=A0 const unsigned char *msg =3D data;
> + =C2=A0 =C2=A0 =C2=A0 struct isi_cb_data *cbd =3D opaque;
> + =C2=A0 =C2=A0 =C2=A0 ofono_cbs_set_cb_t cb =3D cbd->cb;
> + =C2=A0 =C2=A0 =C2=A0 DBG("");
> +
> + =C2=A0 =C2=A0 =C2=A0 if (!msg)
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 DBG("ISI client error:=
 %d", g_isi_client_error(client));
> +
> + =C2=A0 =C2=A0 =C2=A0 cbs_subscription_nr =3D 0;
> + =C2=A0 =C2=A0 =C2=A0 CALLBACK_WITH_SUCCESS(cb, cbd->data);
> + =C2=A0 =C2=A0 =C2=A0 goto out;
> +out:
> + =C2=A0 =C2=A0 =C2=A0 g_free(cbd);
> + =C2=A0 =C2=A0 =C2=A0 return TRUE;
> +}
> +
> +static void isi_clear_topics(struct ofono_cbs *cbs,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ofono_cbs_set_cb_t cb, void *data)
> +{
> + =C2=A0 =C2=A0 =C2=A0 struct cbs_data *cd =3D ofono_cbs_get_data(cbs);
> + =C2=A0 =C2=A0 =C2=A0 struct isi_cb_data *cbd =3D isi_cb_data_new(cbs, c=
b, data);
> + =C2=A0 =C2=A0 =C2=A0 uint8_t msg[] =3D {
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 SMS_CB_ROUTING_REQ,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 SMS_ROUTING_RELEASE,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 cbs_subscription_nr, =
=C2=A0 =C2=A0/* Subscription number */
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0x00, =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /* Subscription type */
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0x00, =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /* Fillers */
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0x00,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0x00 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/*No subblocks*/
> + =C2=A0 =C2=A0 =C2=A0 };
> +
> + =C2=A0 =C2=A0 =C2=A0 DBG("");
> +
> + =C2=A0 =C2=A0 =C2=A0 if (g_isi_request_make(cd->client, msg, sizeof(msg=
), CBS_TIMEOUT,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 clear_resp_cb, cbd))
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return;
> +
> + =C2=A0 =C2=A0 =C2=A0 CALLBACK_WITH_FAILURE(cb, data);
> + =C2=A0 =C2=A0 =C2=A0 g_free(cbd);
> +}

And same for the clear_topics callback.

> diff --git a/drivers/isimodem2.5/checkpatch.pl b/drivers/isimodem2.5/chec=
kpatch.pl
> new file mode 100755
> index 0000000..a4d7434

This has no business being in the isimodem driver. I suppose it was
included by mistake.

> +static void isi_query_serial(struct ofono_devinfo *info,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ofono_devinfo_query_cb_t cb,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 void *data)
> +{
> + =C2=A0 =C2=A0 =C2=A0 char imei[16]; /* IMEI 15 digits + 1 null*/
> + =C2=A0 =C2=A0 =C2=A0 char numbers[] =3D "1234567890";
> + =C2=A0 =C2=A0 =C2=A0 FILE *fp =3D fopen("/etc/imei", "r");
> + =C2=A0 =C2=A0 =C2=A0 DBG("");
> +
> + =C2=A0 =C2=A0 =C2=A0 if (fp =3D=3D NULL) {
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 DBG("failed to open /e=
tc/imei file");
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 CALLBACK_WITH_FAILURE(=
cb, "", data);
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return;
> + =C2=A0 =C2=A0 =C2=A0 }
> +
> + =C2=A0 =C2=A0 =C2=A0 if (fgets(imei, 16, fp)) {
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 DBG(" IMEI =3D %s", im=
ei);
> +
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (15 =3D=3D strspn(i=
mei, numbers))
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 CALLBACK_WITH_SUCCESS(cb, imei, data);
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 else
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 CALLBACK_WITH_FAILURE(cb, "", data);
> + =C2=A0 =C2=A0 =C2=A0 }
> +
> + =C2=A0 =C2=A0 =C2=A0 fclose(fp);
> +}

So the IMEI is not stored on the modem at all. This obviously needs a
quirk, but I wonder if it would be cleaner to handle this in the modem
plugin. See for example how GPIO lines are handled in the n900 driver.

> diff --git a/drivers/isimodem2.5/gpds-context.c b/drivers/isimodem2.5/gpd=
s-context.c
> new file mode 100644
> index 0000000..5bc9d17

Is there actually anything different here, except for the name change?
It's using a forked version of GIsiPipe, but I'm pretty sure we can
just add the missing bits into the existing GIsiPipe class.

Anyway, the gprs-context driver has changed quite drastically
recently, as the oFono core GPRS support for multiple contexts changed
the way the drivers are allocated.

> +static gboolean decode_reg_status(struct netreg_data *nd, const guint8 *=
msg,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 size_t len, =
int *status, int *lac,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 int *ci, int=
 *tech)
> +{
> + =C2=A0 =C2=A0 =C2=A0 GIsiSubBlockIter iter;
> + =C2=A0 =C2=A0 =C2=A0 g_isi_sb_iter_init(&iter, msg, len, 0);
> +
> + =C2=A0 =C2=A0 =C2=A0 while (g_isi_sb_iter_is_valid(&iter)) {
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 DBG("Sub-block %s",
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 net_subb=
lock_name(g_isi_sb_iter_get_id(&iter)));
> +
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 switch (g_isi_sb_iter_=
get_id(&iter)) {
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 case NET_MODEM_REG_INF=
O_COMMON: {
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 guint8 byte =3D 0;
> +
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 if (!g_isi_sb_iter_get_byte(&iter, &byte, 2))
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return FALSE;
> +
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 if (!g_isi_sb_iter_get_byte(&iter,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &nd->last_reg_mode, 3))
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return FALSE;
> +
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 *status =3D byte;
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 break;
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 case NET_MODEM_GSM_REG=
_INFO: {
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 guint16 word =3D 0;
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 guint32 dword =3D 0;
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 guint8 egprs =3D 0;
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 guint8 hsdpa =3D 0;
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 guint8 hsupa =3D 0;
> +
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 if (!g_isi_sb_iter_get_word(&iter, &word, 2) ||
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 !g_isi_sb_iter_get_dword(&iter, &dword, =
4) ||
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 !g_isi_sb_iter_get_byte(&iter, &egprs, 1=
7) ||
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 !g_isi_sb_iter_get_byte(&iter, &hsdpa, 2=
0) ||
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 !g_isi_sb_iter_get_byte(&iter, &hsupa, 2=
1))
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return FALSE;
> +
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 *ci =3D (int)dword;
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 *lac =3D (int)word;
> +
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 switch (nd->rat) {
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 case NET_GSM_RAT:
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 *tech =3D ACCESS_TECHNOLOGY_GSM;
> +
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (nd->gsm_compact)
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 *tech =3D AC=
CESS_TECHNOLOGY_GSM_COMPACT;
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 else if (egprs)
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 *tech =3D AC=
CESS_TECHNOLOGY_GSM_EGPRS;
> +
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 break;
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 case NET_UMTS_RAT:
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 *tech =3D 2;
> +
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (hsdpa)
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 *tech =3D AC=
CESS_TECHNOLOGY_UTRAN_HSDPA;
> +
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (hsupa)
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 *tech =3D AC=
CESS_TECHNOLOGY_UTRAN_HSUPA;
> +
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (hsdpa && hsupa)
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 *tech =3D
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ACCES=
S_TECHNOLOGY_UTRAN_HSDPA_HSUPA;
> +
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 break;
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 default:
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 *tech =3D ACCESS_TECHNOLOGY_GSM;
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 }
> +
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 break;
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 default:
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 DBG("Skipping sub-block: %s (%zu bytes)",
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 net_subblock_name(g_isi_sb_iter_get_id(&=
iter)),
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 g_isi_sb_iter_get_len(&iter));
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 break;
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }
> +
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 g_isi_sb_iter_next(&it=
er);
> + =C2=A0 =C2=A0 =C2=A0 }
> +
> + =C2=A0 =C2=A0 =C2=A0 DBG("status=3D%d, lac=3D%d, ci=3D%d, tech=3D%d",
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 (*status), *lac, *ci, =
*tech);
> + =C2=A0 =C2=A0 =C2=A0 return TRUE;
> +}

Just adding the decoding for NET_MODEM_ subblocks here would be
enough. In fact, these subblocks look almost identical to the existing
NET_ subblocks, so adding just extra case statements with the new
codepoints would probably work, too.

> +static void cs_power_on_req(GIsiClient *client)
> +{
> + =C2=A0 =C2=A0 =C2=A0 const unsigned char msg[] =3D {
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 NET_CS_CONTROL_REQ,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0x03,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0x00, /* Sub-block cou=
nt */
> + =C2=A0 =C2=A0 =C2=A0 };
> + =C2=A0 =C2=A0 =C2=A0 DBG("");
> +
> + =C2=A0 =C2=A0 =C2=A0 /* Just send message, ignore the reponse */
> + =C2=A0 =C2=A0 =C2=A0 g_isi_request_make(client, msg, sizeof(msg),
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 NETWORK_SET_TIMEOUT,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 NULL , NULL);
> +}

I think this is a bad idea. I know you're using NET_CS_CONTROL_REQ
here to implement the unregister callback, but the this is basically
just wrapping existing PN_MTC functionality. In general, ISI modems
don't seem to understand what a deregister even means.

In fact, even the D-Bus method seems of little value, and I would
remove it altogether. In any case, leaving this unimplemented is my
preference.

> + =C2=A0 =C2=A0 =C2=A0 /* TODO Here we should notify framework once it
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0* supports this indication e.g.
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0* ofono_netreg_name_notify(netreg, op.name);
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0*/

Right, we need to figure out how NITZ names are to be supported,
particularly with ISI modems.

I've sent some TODO items for this, but we need to figure out how this
is going to work with AT modems as well.

> +static void isi_strength(struct ofono_netreg *netreg,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ofono_netreg_strength_cb_t cb,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 void *data)
> +{
> + =C2=A0 =C2=A0 =C2=A0 struct netreg_data *nd =3D ofono_netreg_get_data(n=
etreg);
> + =C2=A0 =C2=A0 =C2=A0 struct isi_cb_data *cbd =3D isi_cb_data_new(netreg=
, cb, data);
> + =C2=A0 =C2=A0 =C2=A0 const unsigned char msg[] =3D {
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 NET_RSSI_GET_REQ,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 NET_CS_GSM,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 NET_CURRENT_CELL_RSSI,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0, 0, 0, 0 /* Week 18 =
specs requires these */

This is different from the current netreg driver. However, it's easy
enough to alternate, see below.

> +static void reachable_cb(GIsiClient *client, gboolean alive, uint16_t ob=
ject,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0void *opaque)
> +{
> + =C2=A0 =C2=A0 =C2=A0 struct ofono_netreg *netreg =3D opaque;
> +
> + =C2=A0 =C2=A0 =C2=A0 if (!alive) {
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 DBG("Unable to bootsra=
p netreg driver");
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return;
> + =C2=A0 =C2=A0 =C2=A0 }
> +
> + =C2=A0 =C2=A0 =C2=A0 DBG("Resource %s (v%03d.%03d) reachable",
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 pn_resource_name(g_isi=
_client_resource(client)),
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 g_isi_version_major(cl=
ient),
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 g_isi_version_minor(cl=
ient));
> + =C2=A0 =C2=A0 =C2=A0 g_idle_add(isi_netreg_register, netreg);
> +}
> +
> +static int isi_netreg_probe(struct ofono_netreg *netreg, unsigned int ve=
ndor,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 void *user)
> +{
> + =C2=A0 =C2=A0 =C2=A0 GIsiModem *idx =3D user;
> + =C2=A0 =C2=A0 =C2=A0 struct netreg_data *nd =3D g_try_new0(struct netre=
g_data, 1);
> +
> + =C2=A0 =C2=A0 =C2=A0 if (!nd)
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return -ENOMEM;
> +
> + =C2=A0 =C2=A0 =C2=A0 nd->client =3D g_isi_client_create(idx, PN_MODEM_N=
ETWORK);
> +
> + =C2=A0 =C2=A0 =C2=A0 if (!nd->client) {
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 g_free(nd);
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return -ENOMEM;
> + =C2=A0 =C2=A0 =C2=A0 }
> +
> + =C2=A0 =C2=A0 =C2=A0 ofono_netreg_set_data(netreg, nd);
> + =C2=A0 =C2=A0 =C2=A0 g_isi_verify(nd->client, reachable_cb, netreg);
> + =C2=A0 =C2=A0 =C2=A0 nd->cs_active =3D FALSE; /* Assume CS is inactive =
(updated later) */
> + =C2=A0 =C2=A0 =C2=A0 return 0;
> +}

I would suggest probing for both PN_NETWORK and PN_MODEM_NETWORK here.
Then which ever answers first gets used. After we know with which
resource we're working with, overloading a few of the ISI messages is
enough to make this driver work with both versions of modems.

I didn't go through all of the patch, but from what I can see, we can
pretty well fold the WG2.5 modem support into the existing drivers.

Cheers,
Aki

--===============3080677765695401657==--

