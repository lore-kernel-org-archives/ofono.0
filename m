Content-Type: multipart/mixed; boundary="===============3237669379531669379=="
MIME-Version: 1.0
From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [PATCH 1/2] simutil: M9, M11, Minor style fixes and indentation
Date: Tue, 18 Jan 2011 15:17:52 +0100
Message-ID: <1295360272.3873.172.camel@aeonflux>
In-Reply-To: <1295353930-25914-1-git-send-email-jessica.j.nilsson@stericsson.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3237669379531669379==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Jessica,

<snip>
 =

>  enum ber_tlv_data_type ber_tlv_iter_get_class(struct ber_tlv_iter *iter);
> -enum ber_tlv_data_encoding_type
> -	ber_tlv_iter_get_encoding(struct ber_tlv_iter *iter);
> +enum ber_tlv_data_encoding_type ber_tlv_iter_get_encoding(
> +						struct ber_tlv_iter *iter);

leave this one out. It is such a rare corner case with return parameter
being an enum and a long function name. There is really no unique right
way to make this look good. Whatever you try the break will be ugly.

Regards

Marcel



--===============3237669379531669379==--

