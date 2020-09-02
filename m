Content-Type: multipart/mixed; boundary="===============2080178398388733435=="
MIME-Version: 1.0
From: Rakes Pani <rakespani@gmail.com>
Subject: Re: Unable to establish ppp connection with Huawei dongle
Date: Wed, 02 Sep 2020 11:18:05 +0000
Message-ID: <20200902111805.2753.79654@ml01.vlan13.01.org>
In-Reply-To: <20200902110055.6yzsqncyjnxot5bv@lem-wkst-02.lemonage>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2080178398388733435==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Lars,

Only difference I see in case of pppd , config request is going with below =
options.

Options: (16 bytes), Async Control Character Map(0x00000000), Magic Number,=
 Protocol Field Compression, Address and Control Field Compression

In case of ofono , none of the options are sent .
So I tried hard coding the option's  as ppd , but still no response

+++ b/gatchat/ppp_lcp.c
@@ -119,6 +119,60 @@ static void lcp_generate_config_options(struct lcp_dat=
a *lcp)
        lcp->options_len =3D len;
 }

+static void lcp_generate_config_options_modified(struct pppcp_data *pppcp,=
 struct lcp_data *lcp)
+{
+       guint16 len =3D 0;
+
+       //if (lcp->req_options & REQ_OPTION_ACCM) {
+               guint32 accm;
+               lcp->accm =3D 0U;
+               accm =3D htonl(lcp->accm);
+
+               lcp->options[len] =3D ACCM;
+               lcp->options[len + 1] =3D 6;
+               memcpy(lcp->options + len + 2, &accm, sizeof(accm));
+
+               len +=3D 6;
+       //}
+
+       if (lcp->req_options & REQ_OPTION_MRU) {
+               guint16 mru;
+
+               mru =3D htons(lcp->mru);
+
+               lcp->options[len] =3D MRU;
+               lcp->options[len + 1] =3D 4;
+               memcpy(lcp->options + len + 2, &mru, sizeof(mru));
+
+               len +=3D 4;
+       }
+
+       //if (lcp->req_options & REQ_OPTION_ACFC) {
+               lcp->options[len] =3D ACFC;
+               lcp->options[len + 1] =3D 2;
+
+               len +=3D 2;
+       //}
+
+       //if (lcp->req_options & REQ_OPTION_PFC) {
+               lcp->options[len] =3D PFC;
+               lcp->options[len + 1] =3D 2;
+
+               len +=3D 2;
+       //}
+
+       guint32 magic_number =3D 123456789;
+       guint32 magic_number1 =3D htonl(magic_number);
+
+       lcp->options[len] =3D MAGIC_NUMBER;
+       lcp->options[len + 1] =3D 6;
+       memcpy(lcp->options + len + 2, &magic_number1, sizeof(magic_number1=
));
+       len +=3D 6;
+
+
+       lcp->options_len =3D len;
+}
+
 static void lcp_reset_config_options(struct lcp_data *lcp)
 {
        /* Using the default ACCM */
@@ -392,7 +446,8 @@ struct pppcp_data *lcp_new(GAtPPP *ppp, gboolean is_ser=
ver)

        pppcp_set_data(pppcp, lcp);

-       lcp_reset_config_options(lcp);
+       //lcp_reset_config_options(pppcp,lcp);
+       lcp_generate_config_options_modified(pppcp,lcp);
        pppcp_set_local_options(pppcp, lcp->options, lcp->options_len);

        return pppcp;

Regards,
Rakes
--===============2080178398388733435==--

