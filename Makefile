# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Makefile                                           :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: auzun <auzun@student.42.fr>                +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2023/05/01 03:06:26 by auzun             #+#    #+#              #
#    Updated: 2023/05/25 03:23:09 by auzun            ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

RED				=	$'\e[0;31m
GREEN			=	$'\e[32m
BOLD			=	$'\e[1m
UNDER			=	$'\e[4m
END				=	$'\e[0m

VOLUMES_PATH	=	/home/auzun/data/mariadb \
					/home/auzun/data/wordpress

all:
					if sudo test $$(sudo docker-compose -f src/docker-compose.yml images | wc -l) -eq 4; then \
						echo "$(RED) All services are already build$(END)"; \
					else \
						if sudo test -d "/home/auzun/data/mariadb/" && sudo test -d "/home/auzun/data/wordpress/"; then \
							echo "$(RED) Volumes are already created$(END)"; \
						else \
							sudo mkdir -p $(VOLUMES_PATH); \
							echo "$(GREEN) Volumes have been successfully created.$(END)"; \
						fi; \
						sudo docker-compose -f src/docker-compose.yml up -d --build; \
						echo "$(GREEN) All services are ready"; \
						echo " $(BOLD)You can consult the wordpress page using this link -> $(UNDER)auzun.42.fr$(END)"; \
					fi

up:
					if sudo test $$(sudo docker-compose -f src/docker-compose.yml images | wc -l) -ne 4; then \
						echo "$(RED) Containers were not built$(END)"; \
					elif sudo test $$(sudo docker ps | wc -l) -eq 4; then \
						echo "$(RED) All services are already running$(END)"; \
					else \
						sudo docker-compose -f src/docker-compose.yml up -d; \
						echo "$(GREEN) All services are ready$(END)"; \
					fi

stop:
					if sudo test $$(sudo docker ps | wc -l) -eq 1; then \
						echo "$(RED) No service is build or up$(END)"; \
					else \
						sudo docker-compose -f src/docker-compose.yml stop; \
						echo "$(GREEN) All services have been successfully stopped$(END)"; \
					fi

clean:
					if sudo test $$(sudo docker-compose -f src/docker-compose.yml images | wc -l) -eq 1; then \
						echo "$(RED) All services are already removed$(END)"; \
					else \
						sudo docker-compose -f src/docker-compose.yml down; \
						echo "$(GREEN) All services are removed$(END)"; \
					fi

fclean:				clean
					sudo docker system prune -af > /dev/null 2>&1; \
					if sudo test -d "/home/auzun/data/mariadb/" && sudo test -d "/home/auzun/data/wordpress/"; then \
						sudo rm -rf "/home/auzun/data/"; \
						echo "$(GREEN) Volumes have been successfully deleted$(END)"; \
					else \
						echo "$(RED) Volumes are already removed$(END)"; \
					fi

re:					fclean
					make --no-print-directory all

.PHONY:				all up stop clean fclean re
.SILENT: