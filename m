Content-Type: multipart/mixed; boundary="===============7215111996268141556=="
MIME-Version: 1.0
From: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
Subject: Re: [PATCH 4/5] handsfree-audio: Add function to get the codecs
Date: Fri, 05 Apr 2013 19:00:22 -0300
Message-ID: <20130405220022.GJ2715@samus>
In-Reply-To: <515F44D7.5030404@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7215111996268141556==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Denis,

On 16:40 Fri 05 Apr, Denis Kenzior wrote:
> Hi Vinicius,
> =

> On 04/05/2013 03:56 PM, Vinicius Costa Gomes wrote:
> >Hi Denis,
> >
> >On 12:32 Fri 05 Apr, Denis Kenzior wrote:
> >>>
> >>>+int ofono_handsfree_get_codecs(unsigned char *buffer, int buffer_len)
> >>>+{
> >>>+	int len;
> >>>+
> >>>+	if (agent =3D=3D NULL)
> >>>+		return -EIO;
> >>>+
> >>>+	len =3D MIN(buffer_len, agent->codecs_len);
> >>>+	memcpy(buffer, agent->codecs, len);
> >>>+
> >>>+	return len;
> >>>+}
> >>>+
> >>
> >>Do we really want to memcpy here or return a const unsigned char
> >>array?  Also, right now we explicitly only support CVSD and mSBC, so
> >>this is overkill.
> >
> >As we can assume that we always support CVSD, one idea is to have someth=
ing
> >like ofono_handsfree_audio_has_msbc() instead of the get_codecs() functi=
on.
> >How does it sound?
> =

> I tend to like this better.  Perhaps we can name this function a
> more generic 'has_wideband()' instead.  In case we want to provide
> support for custom codecs in the future.

Sounds good.


Cheers,
-- =

Vinicius

--===============7215111996268141556==--

