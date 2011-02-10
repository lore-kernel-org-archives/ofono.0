Content-Type: multipart/mixed; boundary="===============4804167901729700039=="
MIME-Version: 1.0
From: Simon LETHBRIDGE <simon.lethbridge@stericsson.com>
Subject: [PATCHv2] doc: Assisted Satellite Navigation API and Agent API
Date: Thu, 10 Feb 2011 15:48:07 +0100
Message-ID: <B4268AAFAFA3E244B5B0641D5914917048CB1F3765@EXDCVYMBSTM006.EQ1STM.local>
In-Reply-To: <mailman.1.1297281601.22675.ofono@ofono.org>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4804167901729700039==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Fred,

> +		void ResetAssistanceData()
> +
> +			A request has been received from the network that all
> +			assistance data should be reset.  This is used for 3gpp
> +			performance tests.
>
> Sorry to come back so late of this. By assistance data reset, you meant a=
 reset of all positioning stored information? Like used in 3GPP conformance=
 testing (44.014 ? 8.15 for instance)?
> The knowledge of positioning information is somehow "Assistance" informat=
ion, but this is not the wording I'm used to.
>
Yes.  Since this is a 3GPP performance test most of the stored information =
will have been received from the network as assistance data. =


The recs that I have in mind are 34.123 and 51.10 Section 70

Regards,

Simon

--===============4804167901729700039==--

