Received: from mail5.g24.pair.com (mail5.g24.pair.com [66.39.139.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7E5F4A29
	for <ofono@lists.linux.dev>; Thu, 13 Feb 2025 00:16:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.39.139.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739405803; cv=none; b=dxCthgzkizY4UdzJxxxqx7wDaFXnExcpKfn9AHniVdT7pq5sjPKr2VzMVTmFeQIyeaaDVzD2o02IQu0jXBjLakFfMR2Gp20xJNbtBNsv02FA3m2wdYPfL7S1WXtouEDqRD1GqeK8ZSWIM/fI7d8M9JfmQVSBnO629RjMtSFu+PQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739405803; c=relaxed/simple;
	bh=6j5V3xl0P6Toafw9OEpHPv39FrY7NS7IELy19X0v+Sc=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=GuUD8MdSfDA96ye1OeEVRRqyp/jn6qfO7No/04OrqmbaflxBm4cqt2zGScL5G/l+wJNJHH0OolBHPo/Ifg7kFZoSygTz7n/0xCC6kPe7rJzyKzrynsSfrt/Clq23pHFs1fFCjh00oNOZN8WCa2Q2ZyOgDd9Sa4Gv0meUH4mRzT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com; spf=pass smtp.mailfrom=nuovations.com; dkim=pass (2048-bit key) header.d=nuovations.com header.i=@nuovations.com header.b=YTddOXWu; arc=none smtp.client-ip=66.39.139.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nuovations.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nuovations.com header.i=@nuovations.com header.b="YTddOXWu"
Received: from mail5.g24.pair.com (localhost [127.0.0.1])
	by mail5.g24.pair.com (Postfix) with ESMTP id B2AA41648AC;
	Wed, 12 Feb 2025 19:16:39 -0500 (EST)
Received: from smtpclient.apple (c-24-6-12-99.hsd1.ca.comcast.net [24.6.12.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail5.g24.pair.com (Postfix) with ESMTPSA id 6560012516C;
	Wed, 12 Feb 2025 19:16:39 -0500 (EST)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3776.700.51.11.1\))
Subject: Re: [PATCH 09/10] udevng: Set the QMI minimum service request period
 for Quectel BG96 modems.
From: Grant Erickson <gerickson@nuovations.com>
In-Reply-To: <c4f049bc-12ad-40dd-ac1a-7886e8fb7acc@gmail.com>
Date: Wed, 12 Feb 2025 16:16:28 -0800
Cc: ofono@lists.linux.dev
Content-Transfer-Encoding: quoted-printable
Message-Id: <3369A7A4-341F-4C95-8CC3-BCDC8BA25548@nuovations.com>
References: <cover.1739339173.git.gerickson@nuovations.com>
 <5f9277b84477f13890620d4dbda3804881142946.1739339173.git.gerickson@nuovations.com>
 <c4f049bc-12ad-40dd-ac1a-7886e8fb7acc@gmail.com>
To: Denis Kenzior <denkenz@gmail.com>
X-Mailer: Apple Mail (2.3776.700.51.11.1)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nuovations.com; h=content-type:mime-version:subject:from:in-reply-to:date:cc:content-transfer-encoding:message-id:references:to; s=pair-202401062137; bh=RiamMi4hSFQCXElQ50jYPgD3NZSH5Q9N4ZJd/PKuQU4=; b=YTddOXWu1TeKtCIaAb8sm85Y1wQgb159jbOdI0AZluAdDcDJf3zMwmoAw73S0AKGlrt2kvVAkumOToFmYMm5Y5XGjSNBGKXQLmUULCLlEKb53be4GVjra8n6MraeMxiW39BbKOzlPOxeSWy2MVyV2ZL2SooQs5DsGDDKbXvDSnwuh6KNYI0eag+u9MIEPakwChTRn1EkjxGAUzpifH16d7vo2JSNNZtgfJmUI+ALGvPzKjq1ggsLTfbfj1Ag3i5TIszwWJO6s7vJW2Yv3aLmpkZV9Bg+mxPn6F0i/VUOYdWbsHKEBmVKD1Oic0VJgMam9wrPVsWsbZ5C6rlWT4uOrQ==
X-Scanned-By: mailmunge 3.10 on 66.39.139.36

On Feb 12, 2025, at 11:30=E2=80=AFAM, Denis Kenzior <denkenz@gmail.com> =
wrote:
> On 2/11/25 11:52 PM, Grant Erickson wrote:
>> The Quectel Wireless Solutions Co., Ltd. (2c7c) BG96 CAT-M1/NB-IoT
>> modem (0296) has a firmware issue where it can lock up and hang (not
>> responding to subsequent commands) due to high QMI service request
>> arrival rates. If the vendor and model match those, then rate limit
>> QMI service requests to no more than one every 2,000 us.
>> ---
>>  plugins/udevng.c | 14 ++++++++++++++
>>  1 file changed, 14 insertions(+)
>> diff --git a/plugins/udevng.c b/plugins/udevng.c
>> index 64875a47752b..e7cf494a70ff 100644
>> --- a/plugins/udevng.c
>> +++ b/plugins/udevng.c
>> @@ -1118,6 +1118,20 @@ static gboolean setup_quectelqmi(struct =
modem_info *modem)
>>     DBG("%s", modem->syspath);
>>  + /*
>> + * The Quectel Wireless Solutions Co., Ltd. (2c7c) BG96
>> + * CAT-M1/NB-IoT modem (0296) has a firmware issue where it can
>> + * lock up and hang (not responding to subsequent commands) due to
>> + * high QMI service request arrival rates. If the vendor and model
>> + * match those, then rate limit QMI service requests to no more
>> + * than one every 2,000 us.
>> + */
>> + if (g_strcmp0(modem->vendor, "2c7c") =3D=3D 0) {
>=20
> Please use ell for all new code.  l_streq0 or so.
>=20
>> + if (g_strcmp0(modem->model, "0296") =3D=3D 0) {
>> + ofono_modem_set_integer(modem->modem, "QMIMinReqPeriodUs", 2000);
>> + }
>> + }
>=20
> The {} are unnecessary.

Denis,

Noted; will include both in a v2.

Best,

Grant

--=20
Principal
Nuovations

gerickson@nuovations.com
https://www.nuovations.com/

