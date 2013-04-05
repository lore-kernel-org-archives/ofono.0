Content-Type: multipart/mixed; boundary="===============3379213671339749649=="
MIME-Version: 1.0
From: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
Subject: Re: [PATCH 4/5] handsfree-audio: Add function to get the codecs
Date: Fri, 05 Apr 2013 17:56:26 -0300
Message-ID: <20130405205626.GI2715@samus>
In-Reply-To: <515F0ACB.6080408@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3379213671339749649==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Denis,

On 12:32 Fri 05 Apr, Denis Kenzior wrote:
> >
> >+int ofono_handsfree_get_codecs(unsigned char *buffer, int buffer_len)
> >+{
> >+	int len;
> >+
> >+	if (agent =3D=3D NULL)
> >+		return -EIO;
> >+
> >+	len =3D MIN(buffer_len, agent->codecs_len);
> >+	memcpy(buffer, agent->codecs, len);
> >+
> >+	return len;
> >+}
> >+
> =

> Do we really want to memcpy here or return a const unsigned char
> array?  Also, right now we explicitly only support CVSD and mSBC, so
> this is overkill.

As we can assume that we always support CVSD, one idea is to have something
like ofono_handsfree_audio_has_msbc() instead of the get_codecs() function.
How does it sound?

> =

> >  static void agent_free(struct agent *agent)
> >  {
> >  	if (agent->watch>  0)
> =

> Regards,
> -Denis


Cheers,
-- =

Vinicius

--===============3379213671339749649==--

