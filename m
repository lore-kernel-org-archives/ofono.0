Received: from mx0a-003ede02.pphosted.com (mx0a-003ede02.pphosted.com [205.220.169.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EA1D1D54A
	for <ofono@lists.linux.dev>; Tue, 27 Feb 2024 17:02:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.169.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709053344; cv=none; b=irZRGKRg+6kpGy+zWcnKSFi5ycd1brkDAfML7RfFQTEBA8INx5T/8dKWxJrCxoe+FdNzVq1hAj06tAgEEulCUbuBu0CbWsTsZEiJS2dzlSUpn5zXwBkv7a/+Vn5zmlHoZFotidRi0at5JhDndJoQepHiIi2Sv/CqswZqwcCJbwU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709053344; c=relaxed/simple;
	bh=wXn/vBEtXC5ndrO1V0/ryazWF/CFbLlygmqVSZvVfaU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hJcDKsW2dyD7oWYCBpL63KC1ZD/BvdTS1+ffc5k7TVFSdhjEaNAsDtP7/Lj+QzU1b8+QJmbcKSHzhVQaqodwevCpzmg+PeF8NFdfU/JDxn5sXrb4ZxFdBKdHhKLzF7FlhJ5S/n3zCQRVntQoa2ZWs/CZZyKZeHjMH2NU45W4+Z8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=getcruise.com; spf=pass smtp.mailfrom=getcruise.com; dkim=pass (2048-bit key) header.d=getcruise.com header.i=@getcruise.com header.b=svLvbncN; dkim=pass (2048-bit key) header.d=getcruise.com header.i=@getcruise.com header.b=otYThl/K; arc=none smtp.client-ip=205.220.169.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=getcruise.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=getcruise.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=getcruise.com header.i=@getcruise.com header.b="svLvbncN";
	dkim=pass (2048-bit key) header.d=getcruise.com header.i=@getcruise.com header.b="otYThl/K"
Received: from pps.filterd (m0286615.ppops.net [127.0.0.1])
	by mx0b-003ede02.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 41RCfItC006011
	for <ofono@lists.linux.dev>; Tue, 27 Feb 2024 09:02:19 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=getcruise.com;
	 h=mime-version:references:in-reply-to:from:date:message-id
	:subject:to:cc:content-type:content-transfer-encoding; s=
	ppemail; bh=gJR8NpxwLfu8V5Et8G3Q8Td67UZlks8o9sAHlEnnrBg=; b=svLv
	bncNlAYOXme/YpGfRlPqs2RZ7xTiwLVbXXzjvfetCwJl8TuOqWffRsaJyRwLMnaq
	fWFJM+AZEX6+qi3bN9xH6RrY+jbmZHFTez1ZYxBKvGE24PxXS2jH9gD7xfGaMtYz
	c2viTZ9T9x5znSxIjLCV4e/ngsu4cM9NWqHrpTOvdqpUJOmQjDstGJXHdzFemkv5
	N5fdovxXVFwXJj4AR8dSzSDBMGZxGmbQtWKJnLiqbHwUgsSGAQgAL+dhFOdLo9je
	l6mQ5SJLUPvukY19HxbatUbm2MSo1m1UKF0DRSrNta2HvnIRgClE3+QAQH7aoXg+
	KAKlheY5/SibURjRJg==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0b-003ede02.pphosted.com (PPS) with ESMTPS id 3wfdhpac4t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <ofono@lists.linux.dev>; Tue, 27 Feb 2024 09:02:18 -0800 (PST)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-42e2506ac53so74964011cf.0
        for <ofono@lists.linux.dev>; Tue, 27 Feb 2024 09:02:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=getcruise.com; s=google; t=1709053337; x=1709658137; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gJR8NpxwLfu8V5Et8G3Q8Td67UZlks8o9sAHlEnnrBg=;
        b=otYThl/KyG8NPISF/M2BSOKf/fEawF9cC+hPg9/g8fGcNHQev4RR/Q7WRYg9Sypq80
         g4QUXiJMS6LSpOrn+fGgbvkqr3NL4Re8dBXE/epg9n2XM/TuJcHwSkToe91/00DU97d8
         Yn5G8gK99vzmy3W9sa9tlM0xYO6GO9eDNzz8KDQXvmUZVyph1gspLOQew/xhDkjMsVT9
         uIHbQNjtOOjBCjgSQHoBSIv6Hn9uxRIQsL1F8JeEYZ9rS6qz2Zj+ZwGbzEAACSintGXs
         XGAQXM1XlQaqPZaAXZs+d3v3MnKFvU5n/A1ADWxA2td/KGTwLF4+odDzO1wp1M10ydZd
         EtIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709053337; x=1709658137;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gJR8NpxwLfu8V5Et8G3Q8Td67UZlks8o9sAHlEnnrBg=;
        b=Zg7BTPm3RDHcyjK8fJkqxUrgzFqZuWkJqo9Ff8SMXGFx1ItKdej1+wQ/NKTuILVOOG
         odbbjcehGwWK7oPRka8zIhEViYNKMLJFyuSMTTqs5ODxho1AHlOBKHa/EtOA/2NBR9K6
         CevresQw/IBeYJYaK3poUNS7SZ2ndebrDCosSOXa6d2+7d3hUwPJsvGtTgvLRx8iLtCR
         r0fusZ1r+4WL01iJp3PrdWD92mb3JR0KU83VwStVAYZkQKaN6NWDp0KUiHEHZ4yEaA51
         UviApfr/UUeJ92bPWU6LusV8r4A9Xc/hrlNMMk29UJaaXK++9PVjww0/c5eTgRKVyoFd
         TQsQ==
X-Gm-Message-State: AOJu0YwkE/t2Nd2+YA4X2qvFU12XneasC1EiEbzWO8W8tufybORMHuDp
	NQLddIzFqb3MCkfOelrJJA1nifepPx5/JBDJ1FiSFMDmfboSBlQUj9j+GSBafr2lK9gpP4VJJla
	EOAt+LMdUt9ODJu+Npin8JtwXTAKFeCfR7s5fhS+fCnBmKyoeE4FE4vOOz+Aoyu5mSHjMbwONk7
	i/3OgvUSh+NlnKFtlu7drpaYrCuF3LWQDHSo8=
X-Received: by 2002:ac8:5f07:0:b0:42e:9ef2:4b5f with SMTP id x7-20020ac85f07000000b0042e9ef24b5fmr2334950qta.30.1709053336504;
        Tue, 27 Feb 2024 09:02:16 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHYRTzHB0z5RnMqxmjDv2Szx/nibCfEPMrJmDvtHdbK0aVDuqOBfkAB3svjbx7mZmL87FxO55vmVOH31jWzCyw=
X-Received: by 2002:ac8:5f07:0:b0:42e:9ef2:4b5f with SMTP id
 x7-20020ac85f07000000b0042e9ef24b5fmr2334894qta.30.1709053336028; Tue, 27 Feb
 2024 09:02:16 -0800 (PST)
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240227033523.123542-1-steve.schrock@getcruise.com> <6B4C7945-566A-41F7-9051-0B004E0BC9F2@holtmann.org>
In-Reply-To: <6B4C7945-566A-41F7-9051-0B004E0BC9F2@holtmann.org>
From: Steve Schrock <steve.schrock@getcruise.com>
Date: Tue, 27 Feb 2024 11:01:40 -0600
Message-ID: <CAPUe8X_-tFcY-fOXytCLeLdG-PuMAwV358AKfZ5TN1czLErdHg@mail.gmail.com>
Subject: Re: [EXT] Re: [PATCH] qmimodem: First QRTR commit: service discovery
To: Marcel Holtmann <marcel@holtmann.org>
Cc: ofono@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-GUID: re6twoKYui3m3OX-vj_d7O9_Vz9-1nOK
X-Proofpoint-ORIG-GUID: re6twoKYui3m3OX-vj_d7O9_Vz9-1nOK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-27_03,2024-02-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 lowpriorityscore=0
 phishscore=0 adultscore=0 impostorscore=0 mlxlogscore=999
 priorityscore=1501 malwarescore=0 bulkscore=0 spamscore=0 suspectscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2402120000 definitions=main-2402270131

Thank you for the review explanations, Marcel. I understand that these
were some ugly changes while awaiting the QRTR modem discovery,
hopefully in udevng if possible. For now I will submit the changes
that are entirely contained in qmi. This code will not be reachable
without applying the extra changes in my earlier patch.

Regards,
Steve


On Tue, Feb 27, 2024 at 12:29=E2=80=AFAM Marcel Holtmann <marcel@holtmann.o=
rg> wrote:
>
> Hi Steve,
>
> > This change allows the developer to force the /gobi_0 modem to be initi=
alized
> > by passing --enable-qrtr to configure. Enabling QRTR will disable the e=
xisting
> > QMUX implementation. This is only temporary -- discovery of the QRTR
> > modem will be implemented later.
>
> please send these as RFC patches since they can not be applied upstream, =
not even temporary.
>
> > QRTR service discovery works by sending QRTR_TYPE_NEW_LOOKUP to
> > the special socket of type AF_QIPCRTR. Then the services are received
> > one-by-one. Soon they will be stored and made available for use by the
> > qmi client.
>
> If possible modifications to drivers/ and plugins/ should be split into s=
eparate patches.
>
> > Since the QRTR implementation does not implement shutdown, I modified
> > gobi to handle the failure to avoid lengthy timeouts.
>
> Just create a new plugin. The Gobi plugin is really the wrong place for t=
hat. If I remember this correctly, then Gobi was a set of cards talking som=
e of the original versions of QMUX+QMI.
>
> > ---
> > Makefile.am            |   5 +
> > configure.ac           |   9 ++
> > drivers/qmimodem/qmi.c | 231 +++++++++++++++++++++++++++++++++++++++++
> > drivers/qmimodem/qmi.h |   1 +
> > plugins/gobi.c         |  40 ++++++-
> > 5 files changed, 285 insertions(+), 1 deletion(-)
> >
> > diff --git a/Makefile.am b/Makefile.am
> > index 85bebae9..afec6997 100644
> > --- a/Makefile.am
> > +++ b/Makefile.am
> > @@ -386,6 +386,11 @@ builtin_sources +=3D $(qmi_sources) \
> > drivers/qmimodem/call-forwarding.c
> >
> > builtin_sources +=3D plugins/gobi.c
> > +
> > +if QMIMODEM_QRTR
> > +builtin_modules +=3D gobi
> > +endif
> > +
>
> If the QMIMODEM can support QRTR then just enable a new plugins/qrtr.c al=
ong with the plugins/gobi.c, but don=E2=80=99t intermix it please. So far w=
e just enabled the drivers support and with that it enabled the plugins. Do=
ing this more fine grained creates a complexity that I rather not have righ=
t now.
>
> > endif
> >
> > if MBIMMODEM
> > diff --git a/configure.ac b/configure.ac
> > index 9fa6531a..14b37eef 100644
> > --- a/configure.ac
> > +++ b/configure.ac
> > @@ -227,6 +227,15 @@ AC_ARG_ENABLE(qmimodem, AS_HELP_STRING([--disable-=
qmimodem],
> > [enable_qmimodem=3D${enableval}])
> > AM_CONDITIONAL(QMIMODEM, test "${enable_qmimodem}" !=3D "no")
> >
> > +AC_ARG_ENABLE(qrtr, AS_HELP_STRING([--enable_qrtr],
> > + [enable Qualcomm QRTR modem support (WIP)]),
> > + [enable_qrtr=3D${enableval}],
> > + [enable_qrtr=3Dno])
> > +AM_CONDITIONAL(QMIMODEM_QRTR, test "${enable_qrtr}" !=3D "no")
> > +if (test "${enable_qrtr}" =3D=3D "yes"); then
> > + AC_DEFINE(QMIMODEM_QRTR, [], [forces Qualcomm QRTR instead of QMUX])
> > +fi
> > +
> > AC_ARG_ENABLE(mbimmodem, AS_HELP_STRING([--disable-mbimmodem],
> > [disable MBIM modem support]),
> > [enable_mbimmodem=3D${enableval}])
> > diff --git a/drivers/qmimodem/qmi.c b/drivers/qmimodem/qmi.c
> > index 35751d7c..48f9ce10 100644
> > --- a/drivers/qmimodem/qmi.c
> > +++ b/drivers/qmimodem/qmi.c
> > @@ -33,6 +33,8 @@
> > #include <stdlib.h>
> > #include <string.h>
> > #include <linux/limits.h>
> > +#include <linux/qrtr.h>
> > +#include <sys/socket.h>
> >
> > #include <ell/ell.h>
> >
> > @@ -1874,6 +1876,235 @@ struct qmi_device *qmi_device_new_qmux(const ch=
ar *device)
> > return &qmux->super;
> > }
> >
> > +struct qmi_device_qrtr {
> > + struct qmi_device super;
> > + struct discover_data *discover_data;
> > +};
> > +
> > +static void __debug_ctrl_request(const struct qrtr_ctrl_pkt *packet,
> > + qmi_debug_func_t function,
> > + void *user_data)
> > +{
> > + char strbuf[72 + 16], *str;
> > + const char *type;
> > +
> > + if (!function)
> > + return;
> > +
> > + str =3D strbuf;
> > + str +=3D sprintf(str, "    %s",
> > + __service_type_to_string(QMI_SERVICE_CONTROL));
> > +
> > + type =3D "_pkt";
> > +
> > + str +=3D sprintf(str, "%s cmd=3D%d", type,
> > + L_LE32_TO_CPU(packet->cmd));
> > +
> > + function(strbuf, user_data);
> > +}
> > +
> > +static void handle_control_packet(struct qmi_device_qrtr *qrtr,
> > + const struct qrtr_ctrl_pkt *packet)
> > +{
> > + struct qmi_device *device =3D &qrtr->super;
> > + uint32_t cmd;
> > + uint32_t type;
> > + uint32_t instance;
> > + uint32_t version;
> > + uint32_t node;
> > + uint32_t port;
> > +
> > + __debug_ctrl_request(packet, device->debug_func,
> > + device->debug_data);
> > +
> > + cmd =3D L_LE32_TO_CPU(packet->cmd);
> > + if (cmd !=3D QRTR_TYPE_NEW_SERVER) {
> > + DBG("Unknown command: %d", cmd);
> > + return;
> > + }
> > +
> > + if (!packet->server.service && !packet->server.instance &&
> > + !packet->server.node && !packet->server.port) {
> > + DBG("Initial service discovery has completed");
> > +
> > + if (qrtr->discover_data->func)
> > + qrtr->discover_data->func(qrtr->discover_data->user_data);
> > +
> > + discover_data_free(qrtr->discover_data);
> > + qrtr->discover_data =3D NULL;
> > +
> > + return;
> > + }
> > +
> > + type =3D L_LE32_TO_CPU(packet->server.service);
> > + version =3D L_LE32_TO_CPU(packet->server.instance) & 0xff;
> > + instance =3D L_LE32_TO_CPU(packet->server.instance) >> 8;
> > +
> > + node =3D L_LE32_TO_CPU(packet->server.node);
> > + port =3D L_LE32_TO_CPU(packet->server.port);
> > +
> > + if (cmd =3D=3D QRTR_TYPE_NEW_SERVER) {
> > + DBG("New server: Type: %d Version: %d Instance: %d Node: %d Port: %d"=
,
> > + type, version, instance, node, port);
> > + }
> > +}
> > +
> > +static void handle_packet(struct qmi_device_qrtr *qrtr, uint32_t sendi=
ng_port,
> > + const void *buf, ssize_t len)
> > +{
> > + const struct qrtr_ctrl_pkt *packet =3D buf;
> > +
> > + if (sending_port !=3D QRTR_PORT_CTRL) {
> > + DBG("Receive of service data is not implemented");
> > + return;
> > + }
> > +
> > + if ((unsigned long) len < sizeof(*packet)) {
> > + DBG("qrtr control packet is too small");
> > + return;
> > + }
> > +
> > + handle_control_packet(qrtr, packet);
> > +}
> > +
> > +static bool received_qrtr_data(struct l_io *io, void *user_data)
> > +{
> > + struct qmi_device_qrtr *qrtr =3D user_data;
> > + struct sockaddr_qrtr addr;
> > + unsigned char buf[2048];
> > + ssize_t bytes_read;
> > + socklen_t addr_size;
> > +
> > + addr_size =3D sizeof(addr);
> > + bytes_read =3D recvfrom(l_io_get_fd(qrtr->super.io), buf, sizeof(buf)=
, 0,
> > + (struct sockaddr *) &addr, &addr_size);
> > + DBG("Received %ld bytes from Node: %d Port: 0x%x", bytes_read,
> > + addr.sq_node, addr.sq_port);
> > +
> > + if (bytes_read < 0)
> > + return true;
> > +
> > + l_util_hexdump(true, buf, bytes_read, qrtr->super.debug_func,
> > + qrtr->super.debug_data);
> > +
> > + handle_packet(qrtr, addr.sq_port, buf, bytes_read);
> > +
> > + return true;
> > +}
> > +
> > +static int qmi_device_qrtr_discover(struct qmi_device *device,
> > + qmi_discover_func_t func,
> > + void *user_data,
> > + qmi_destroy_func_t destroy)
> > +{
> > + struct qmi_device_qrtr *qrtr =3D
> > + l_container_of(device, struct qmi_device_qrtr, super);
> > + struct discover_data *data;
> > + struct qrtr_ctrl_pkt packet;
> > + struct sockaddr_qrtr addr;
> > + socklen_t addr_len;
> > + int rc;
> > + ssize_t bytes_written;
> > + int fd;
> > +
> > + __debug_device(device, "device %p discover", device);
> > +
> > + if (qrtr->discover_data)
> > + return -EINPROGRESS;
> > +
> > + data =3D l_new(struct discover_data, 1);
> > +
> > + data->super.destroy =3D discover_data_free;
> > + data->device =3D device;
> > + data->func =3D func;
> > + data->user_data =3D user_data;
> > + data->destroy =3D destroy;
> > +
> > + fd =3D l_io_get_fd(device->io);
> > +
> > + /*
> > + * The control node is configured by the system. Use getsockname to
> > + * get its value.
> > + */
> > + addr_len =3D sizeof(addr);
> > + rc =3D getsockname(fd, (struct sockaddr *) &addr, &addr_len);
> > + if (rc) {
> > + DBG("getsockname failed: %s", strerror(errno));
> > + goto error;
> > + }
> > +
> > + if (addr.sq_family !=3D AF_QIPCRTR || addr_len !=3D sizeof(addr)) {
> > + DBG("Unexpected sockaddr from getsockname. family: %d size: %d",
> > + addr.sq_family, addr_len);
> > + rc =3D -EIO;
> > + goto error;
> > + }
> > +
> > + addr.sq_port =3D QRTR_PORT_CTRL;
> > + memset(&packet, 0, sizeof(packet));
> > + packet.cmd =3D L_CPU_TO_LE32(QRTR_TYPE_NEW_LOOKUP);
> > +
> > + bytes_written =3D sendto(fd, &packet,
> > + sizeof(packet), 0,
> > + (struct sockaddr *) &addr, addr_len);
> > + if (bytes_written < 0) {
> > + DBG("Failure sending data: %s", strerror(errno));
> > + rc =3D -errno;
> > + goto error;
> > + }
> > +
> > + l_util_hexdump(false, &packet, bytes_written,
> > + device->debug_func, device->debug_data);
> > +
> > + qrtr->discover_data =3D data;
> > +
> > + return 0;
> > +
> > +error:
> > + l_free(data);
> > +
> > + return rc;
> > +}
> > +
> > +static void qmi_device_qrtr_destroy(struct qmi_device *device)
> > +{
> > + struct qmi_device_qrtr *qrtr =3D
> > + l_container_of(device, struct qmi_device_qrtr, super);
> > +
> > + l_free(qrtr);
> > +}
> > +
> > +static const struct qmi_device_ops qrtr_ops =3D {
> > + .write =3D NULL,
> > + .discover =3D qmi_device_qrtr_discover,
> > + .client_create =3D NULL,
> > + .client_release =3D NULL,
> > + .shutdown =3D NULL,
> > + .destroy =3D qmi_device_qrtr_destroy,
> > +};
> > +
> > +struct qmi_device *qmi_device_new_qrtr(void)
> > +{
> > + struct qmi_device_qrtr *qrtr;
> > + int fd;
> > +
> > + fd =3D socket(AF_QIPCRTR, SOCK_DGRAM, 0);
> > + if (fd < 0)
> > + return NULL;
> > +
> > + qrtr =3D l_new(struct qmi_device_qrtr, 1);
> > +
> > + if (qmi_device_init(&qrtr->super, fd, &qrtr_ops) < 0) {
> > + close(fd);
> > + l_free(qrtr);
> > + return NULL;
> > + }
> > +
> > + l_io_set_read_handler(qrtr->super.io, received_qrtr_data, qrtr, NULL)=
;
> > +
> > + return &qrtr->super;
> > +}
> > +
> > struct qmi_param *qmi_param_new(void)
> > {
> > struct qmi_param *param;
> > diff --git a/drivers/qmimodem/qmi.h b/drivers/qmimodem/qmi.h
> > index 6a3d3415..506fed6b 100644
> > --- a/drivers/qmimodem/qmi.h
> > +++ b/drivers/qmimodem/qmi.h
> > @@ -101,6 +101,7 @@ bool qmi_device_set_expected_data_format(struct qmi=
_device *device,
> > enum qmi_device_expected_data_format format);
> >
> > struct qmi_device *qmi_device_new_qmux(const char *device);
> > +struct qmi_device *qmi_device_new_qrtr(void);
> >
> > struct qmi_param;
> >
> > diff --git a/plugins/gobi.c b/plugins/gobi.c
> > index 99a7d556..cf78ad58 100644
> > --- a/plugins/gobi.c
> > +++ b/plugins/gobi.c
> > @@ -105,6 +105,7 @@ static int gobi_probe(struct ofono_modem *modem)
> > if (!data)
> > return -ENOMEM;
> >
> > +#ifndef QMIMODEM_QRTR
> > kernel_driver =3D ofono_modem_get_string(modem, "KernelDriver");
> > DBG("kernel_driver: %s", kernel_driver);
> >
> > @@ -117,6 +118,9 @@ static int gobi_probe(struct ofono_modem *modem)
> > ofono_modem_get_string(modem, "NetworkInterface"),
> > sizeof(data->main_net_name));
> > DBG("net: %s (%d)", data->main_net_name, data->main_net_ifindex);
> > +#else
> > + (void) kernel_driver;
> > +#endif
>
> #ifdef in the code are the super last resort if there is no other way to =
solve things. It would create a testing nightmare for no good reason. And t=
ricks like "(void) variable" are not acceptable. That just hides serious wa=
rnings that should have been avoided in the first place.
>
> Regards
>
> Marcel
>

--=20


*Confidentiality=C2=A0Note:*=C2=A0We care about protecting our proprietary=
=20
information,=C2=A0confidential=C2=A0material, and trade secrets.=C2=A0This =
message may=20
contain some or all of those things. Cruise will suffer material harm if=20
anyone other than the intended recipient disseminates or takes any action=
=20
based on this message. If you have received this message (including any=20
attachments) in error, please delete it immediately and notify the sender=
=20
promptly.
