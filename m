Received: from mail.holtmann.org (coyote.holtmann.net [212.227.132.17])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A53752F87
	for <ofono@lists.linux.dev>; Tue, 27 Feb 2024 06:29:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.132.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709015384; cv=none; b=fm2i6tDlca1D88gAcPQwMPL7y/Lao+KJusfIX0X0DyLSP+a3A1mE72JKWUhbeqc4kNDEYsMixlKuQStmPxy6qTLKBVrOBTQ4+st2LzmvpkQcb347nqoFVIx+Zeax73k8cbiuvHrTnl/ZVipa1iX1MgqKZ9QcD/5e0RwlzrCL+zs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709015384; c=relaxed/simple;
	bh=/3C8wzHa0gvaSwqHKrTKOQsTQX2qTsfabXQQXevxC9M=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=g7laquog5sklVaol+LzLp0FDKpXCMxsxrAsBZsT2BYPes6hc2VaJ5q/vt6sXqWFDwV4kDj7FTyln2JDERXb35A6B/sYYsdITIB1b/m0bgCtPey0WsCnfw3IuDnkEitAdpXLWbCz4+Y5XITQCnB9N82MpwnA3D3AoIYZdTTzc1Uk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=holtmann.org; spf=pass smtp.mailfrom=holtmann.org; arc=none smtp.client-ip=212.227.132.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=holtmann.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=holtmann.org
Received: from smtpclient.apple (p4fefc7ea.dip0.t-ipconnect.de [79.239.199.234])
	by mail.holtmann.org (Postfix) with ESMTPSA id 82AFECECCB;
	Tue, 27 Feb 2024 07:29:34 +0100 (CET)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3774.400.31\))
Subject: Re: [PATCH] qmimodem: First QRTR commit: service discovery
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20240227033523.123542-1-steve.schrock@getcruise.com>
Date: Tue, 27 Feb 2024 07:29:23 +0100
Cc: ofono@lists.linux.dev
Content-Transfer-Encoding: quoted-printable
Message-Id: <6B4C7945-566A-41F7-9051-0B004E0BC9F2@holtmann.org>
References: <20240227033523.123542-1-steve.schrock@getcruise.com>
To: Steve Schrock <steve.schrock@getcruise.com>
X-Mailer: Apple Mail (2.3774.400.31)

Hi Steve,

> This change allows the developer to force the /gobi_0 modem to be =
initialized
> by passing --enable-qrtr to configure. Enabling QRTR will disable the =
existing
> QMUX implementation. This is only temporary -- discovery of the QRTR
> modem will be implemented later.

please send these as RFC patches since they can not be applied upstream, =
not even temporary.

> QRTR service discovery works by sending QRTR_TYPE_NEW_LOOKUP to
> the special socket of type AF_QIPCRTR. Then the services are received
> one-by-one. Soon they will be stored and made available for use by the
> qmi client.

If possible modifications to drivers/ and plugins/ should be split into =
separate patches.

> Since the QRTR implementation does not implement shutdown, I modified
> gobi to handle the failure to avoid lengthy timeouts.

Just create a new plugin. The Gobi plugin is really the wrong place for =
that. If I remember this correctly, then Gobi was a set of cards talking =
some of the original versions of QMUX+QMI.

> ---
> Makefile.am            |   5 +
> configure.ac           |   9 ++
> drivers/qmimodem/qmi.c | 231 +++++++++++++++++++++++++++++++++++++++++
> drivers/qmimodem/qmi.h |   1 +
> plugins/gobi.c         |  40 ++++++-
> 5 files changed, 285 insertions(+), 1 deletion(-)
>=20
> diff --git a/Makefile.am b/Makefile.am
> index 85bebae9..afec6997 100644
> --- a/Makefile.am
> +++ b/Makefile.am
> @@ -386,6 +386,11 @@ builtin_sources +=3D $(qmi_sources) \
> drivers/qmimodem/call-forwarding.c
>=20
> builtin_sources +=3D plugins/gobi.c
> +
> +if QMIMODEM_QRTR
> +builtin_modules +=3D gobi
> +endif
> +

If the QMIMODEM can support QRTR then just enable a new plugins/qrtr.c =
along with the plugins/gobi.c, but don=E2=80=99t intermix it please. So =
far we just enabled the drivers support and with that it enabled the =
plugins. Doing this more fine grained creates a complexity that I rather =
not have right now.

> endif
>=20
> if MBIMMODEM
> diff --git a/configure.ac b/configure.ac
> index 9fa6531a..14b37eef 100644
> --- a/configure.ac
> +++ b/configure.ac
> @@ -227,6 +227,15 @@ AC_ARG_ENABLE(qmimodem, =
AS_HELP_STRING([--disable-qmimodem],
> [enable_qmimodem=3D${enableval}])
> AM_CONDITIONAL(QMIMODEM, test "${enable_qmimodem}" !=3D "no")
>=20
> +AC_ARG_ENABLE(qrtr, AS_HELP_STRING([--enable_qrtr],
> + [enable Qualcomm QRTR modem support (WIP)]),
> + [enable_qrtr=3D${enableval}],
> + [enable_qrtr=3Dno])
> +AM_CONDITIONAL(QMIMODEM_QRTR, test "${enable_qrtr}" !=3D "no")
> +if (test "${enable_qrtr}" =3D=3D "yes"); then
> + AC_DEFINE(QMIMODEM_QRTR, [], [forces Qualcomm QRTR instead of QMUX])
> +fi
> +
> AC_ARG_ENABLE(mbimmodem, AS_HELP_STRING([--disable-mbimmodem],
> [disable MBIM modem support]),
> [enable_mbimmodem=3D${enableval}])
> diff --git a/drivers/qmimodem/qmi.c b/drivers/qmimodem/qmi.c
> index 35751d7c..48f9ce10 100644
> --- a/drivers/qmimodem/qmi.c
> +++ b/drivers/qmimodem/qmi.c
> @@ -33,6 +33,8 @@
> #include <stdlib.h>
> #include <string.h>
> #include <linux/limits.h>
> +#include <linux/qrtr.h>
> +#include <sys/socket.h>
>=20
> #include <ell/ell.h>
>=20
> @@ -1874,6 +1876,235 @@ struct qmi_device *qmi_device_new_qmux(const =
char *device)
> return &qmux->super;
> }
>=20
> +struct qmi_device_qrtr {
> + struct qmi_device super;
> + struct discover_data *discover_data;
> +};
> +
> +static void __debug_ctrl_request(const struct qrtr_ctrl_pkt *packet,
> + qmi_debug_func_t function,
> + void *user_data)
> +{
> + char strbuf[72 + 16], *str;
> + const char *type;
> +
> + if (!function)
> + return;
> +
> + str =3D strbuf;
> + str +=3D sprintf(str, "    %s",
> + __service_type_to_string(QMI_SERVICE_CONTROL));
> +
> + type =3D "_pkt";
> +
> + str +=3D sprintf(str, "%s cmd=3D%d", type,
> + L_LE32_TO_CPU(packet->cmd));
> +
> + function(strbuf, user_data);
> +}
> +
> +static void handle_control_packet(struct qmi_device_qrtr *qrtr,
> + const struct qrtr_ctrl_pkt *packet)
> +{
> + struct qmi_device *device =3D &qrtr->super;
> + uint32_t cmd;
> + uint32_t type;
> + uint32_t instance;
> + uint32_t version;
> + uint32_t node;
> + uint32_t port;
> +
> + __debug_ctrl_request(packet, device->debug_func,
> + device->debug_data);
> +
> + cmd =3D L_LE32_TO_CPU(packet->cmd);
> + if (cmd !=3D QRTR_TYPE_NEW_SERVER) {
> + DBG("Unknown command: %d", cmd);
> + return;
> + }
> +
> + if (!packet->server.service && !packet->server.instance &&
> + !packet->server.node && !packet->server.port) {
> + DBG("Initial service discovery has completed");
> +
> + if (qrtr->discover_data->func)
> + qrtr->discover_data->func(qrtr->discover_data->user_data);
> +
> + discover_data_free(qrtr->discover_data);
> + qrtr->discover_data =3D NULL;
> +
> + return;
> + }
> +
> + type =3D L_LE32_TO_CPU(packet->server.service);
> + version =3D L_LE32_TO_CPU(packet->server.instance) & 0xff;
> + instance =3D L_LE32_TO_CPU(packet->server.instance) >> 8;
> +
> + node =3D L_LE32_TO_CPU(packet->server.node);
> + port =3D L_LE32_TO_CPU(packet->server.port);
> +
> + if (cmd =3D=3D QRTR_TYPE_NEW_SERVER) {
> + DBG("New server: Type: %d Version: %d Instance: %d Node: %d Port: =
%d",
> + type, version, instance, node, port);
> + }
> +}
> +
> +static void handle_packet(struct qmi_device_qrtr *qrtr, uint32_t =
sending_port,
> + const void *buf, ssize_t len)
> +{
> + const struct qrtr_ctrl_pkt *packet =3D buf;
> +
> + if (sending_port !=3D QRTR_PORT_CTRL) {
> + DBG("Receive of service data is not implemented");
> + return;
> + }
> +
> + if ((unsigned long) len < sizeof(*packet)) {
> + DBG("qrtr control packet is too small");
> + return;
> + }
> +
> + handle_control_packet(qrtr, packet);
> +}
> +
> +static bool received_qrtr_data(struct l_io *io, void *user_data)
> +{
> + struct qmi_device_qrtr *qrtr =3D user_data;
> + struct sockaddr_qrtr addr;
> + unsigned char buf[2048];
> + ssize_t bytes_read;
> + socklen_t addr_size;
> +
> + addr_size =3D sizeof(addr);
> + bytes_read =3D recvfrom(l_io_get_fd(qrtr->super.io), buf, =
sizeof(buf), 0,
> + (struct sockaddr *) &addr, &addr_size);
> + DBG("Received %ld bytes from Node: %d Port: 0x%x", bytes_read,
> + addr.sq_node, addr.sq_port);
> +
> + if (bytes_read < 0)
> + return true;
> +
> + l_util_hexdump(true, buf, bytes_read, qrtr->super.debug_func,
> + qrtr->super.debug_data);
> +
> + handle_packet(qrtr, addr.sq_port, buf, bytes_read);
> +
> + return true;
> +}
> +
> +static int qmi_device_qrtr_discover(struct qmi_device *device,
> + qmi_discover_func_t func,
> + void *user_data,
> + qmi_destroy_func_t destroy)
> +{
> + struct qmi_device_qrtr *qrtr =3D
> + l_container_of(device, struct qmi_device_qrtr, super);
> + struct discover_data *data;
> + struct qrtr_ctrl_pkt packet;
> + struct sockaddr_qrtr addr;
> + socklen_t addr_len;
> + int rc;
> + ssize_t bytes_written;
> + int fd;
> +
> + __debug_device(device, "device %p discover", device);
> +
> + if (qrtr->discover_data)
> + return -EINPROGRESS;
> +
> + data =3D l_new(struct discover_data, 1);
> +
> + data->super.destroy =3D discover_data_free;
> + data->device =3D device;
> + data->func =3D func;
> + data->user_data =3D user_data;
> + data->destroy =3D destroy;
> +
> + fd =3D l_io_get_fd(device->io);
> +
> + /*
> + * The control node is configured by the system. Use getsockname to
> + * get its value.
> + */
> + addr_len =3D sizeof(addr);
> + rc =3D getsockname(fd, (struct sockaddr *) &addr, &addr_len);
> + if (rc) {
> + DBG("getsockname failed: %s", strerror(errno));
> + goto error;
> + }
> +
> + if (addr.sq_family !=3D AF_QIPCRTR || addr_len !=3D sizeof(addr)) {
> + DBG("Unexpected sockaddr from getsockname. family: %d size: %d",
> + addr.sq_family, addr_len);
> + rc =3D -EIO;
> + goto error;
> + }
> +
> + addr.sq_port =3D QRTR_PORT_CTRL;
> + memset(&packet, 0, sizeof(packet));
> + packet.cmd =3D L_CPU_TO_LE32(QRTR_TYPE_NEW_LOOKUP);
> +
> + bytes_written =3D sendto(fd, &packet,
> + sizeof(packet), 0,
> + (struct sockaddr *) &addr, addr_len);
> + if (bytes_written < 0) {
> + DBG("Failure sending data: %s", strerror(errno));
> + rc =3D -errno;
> + goto error;
> + }
> +
> + l_util_hexdump(false, &packet, bytes_written,
> + device->debug_func, device->debug_data);
> +
> + qrtr->discover_data =3D data;
> +
> + return 0;
> +
> +error:
> + l_free(data);
> +
> + return rc;
> +}
> +
> +static void qmi_device_qrtr_destroy(struct qmi_device *device)
> +{
> + struct qmi_device_qrtr *qrtr =3D
> + l_container_of(device, struct qmi_device_qrtr, super);
> +
> + l_free(qrtr);
> +}
> +
> +static const struct qmi_device_ops qrtr_ops =3D {
> + .write =3D NULL,
> + .discover =3D qmi_device_qrtr_discover,
> + .client_create =3D NULL,
> + .client_release =3D NULL,
> + .shutdown =3D NULL,
> + .destroy =3D qmi_device_qrtr_destroy,
> +};
> +
> +struct qmi_device *qmi_device_new_qrtr(void)
> +{
> + struct qmi_device_qrtr *qrtr;
> + int fd;
> +
> + fd =3D socket(AF_QIPCRTR, SOCK_DGRAM, 0);
> + if (fd < 0)
> + return NULL;
> +
> + qrtr =3D l_new(struct qmi_device_qrtr, 1);
> +
> + if (qmi_device_init(&qrtr->super, fd, &qrtr_ops) < 0) {
> + close(fd);
> + l_free(qrtr);
> + return NULL;
> + }
> +
> + l_io_set_read_handler(qrtr->super.io, received_qrtr_data, qrtr, =
NULL);
> +
> + return &qrtr->super;
> +}
> +
> struct qmi_param *qmi_param_new(void)
> {
> struct qmi_param *param;
> diff --git a/drivers/qmimodem/qmi.h b/drivers/qmimodem/qmi.h
> index 6a3d3415..506fed6b 100644
> --- a/drivers/qmimodem/qmi.h
> +++ b/drivers/qmimodem/qmi.h
> @@ -101,6 +101,7 @@ bool qmi_device_set_expected_data_format(struct =
qmi_device *device,
> enum qmi_device_expected_data_format format);
>=20
> struct qmi_device *qmi_device_new_qmux(const char *device);
> +struct qmi_device *qmi_device_new_qrtr(void);
>=20
> struct qmi_param;
>=20
> diff --git a/plugins/gobi.c b/plugins/gobi.c
> index 99a7d556..cf78ad58 100644
> --- a/plugins/gobi.c
> +++ b/plugins/gobi.c
> @@ -105,6 +105,7 @@ static int gobi_probe(struct ofono_modem *modem)
> if (!data)
> return -ENOMEM;
>=20
> +#ifndef QMIMODEM_QRTR
> kernel_driver =3D ofono_modem_get_string(modem, "KernelDriver");
> DBG("kernel_driver: %s", kernel_driver);
>=20
> @@ -117,6 +118,9 @@ static int gobi_probe(struct ofono_modem *modem)
> ofono_modem_get_string(modem, "NetworkInterface"),
> sizeof(data->main_net_name));
> DBG("net: %s (%d)", data->main_net_name, data->main_net_ifindex);
> +#else
> + (void) kernel_driver;
> +#endif

#ifdef in the code are the super last resort if there is no other way to =
solve things. It would create a testing nightmare for no good reason. =
And tricks like "(void) variable" are not acceptable. That just hides =
serious warnings that should have been avoided in the first place.

Regards

Marcel

